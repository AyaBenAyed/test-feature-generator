# generator.py
import os
import re
import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup
from jinja2 import Environment, FileSystemLoader

def clean_html(text):
    if not text:
        return ""
    try:
        return BeautifulSoup(text, "lxml").get_text(separator=" ", strip=True)
    except Exception:
        # fallback si lxml échoue
        return BeautifulSoup(text, "html.parser").get_text(separator=" ", strip=True)

def normalize_step_text(text):
    common_verbs = ['send', 'receive', 'verify', 'check', 'write', 'read', 'press', 'open', 'close', 'select']
    words = text.strip().split()
    if not words:
        return text
    first_word = words[0].lower()
    if first_word in common_verbs:
        return "I " + text[0].lower() + text[1:]
    return text

def extract_tag_table(text):
    if "|" in text:
        lines = [line.strip() for line in text.strip().splitlines() if "|" in line]
        rows = []
        for line in lines:
            parts = [cell.strip() for cell in line.strip('|').split('|')]
            if len(parts) == 2:
                rows.append(parts)
        if rows:
            return rows
    tag_value_pairs = re.findall(r'\b([A-Z]?[0-9]{2,6})[:=]\s*([^\s\[\]\n\r:|]+)', text)
    if tag_value_pairs:
        return [["Tag", "Value"]] + [[tag.strip(), val.strip()] for tag, val in tag_value_pairs]
    return None

def generate_features(xml_path, output_dir):
    """
    Génère des fichiers .feature à partir d'un XML arbitraire.
    Compatible avec n'importe quel fichier XML uploadé.
    """
    current_dir = os.path.dirname(os.path.abspath(__file__))
    env = Environment(loader=FileSystemLoader(current_dir), trim_blocks=True, lstrip_blocks=True)
    template = env.get_template("template.feature.j2")

    tree = ET.parse(xml_path)
    root = tree.getroot()

    generated_files = []

    # Si le XML contient des 'testcase', on les utilise, sinon on crée un scénario générique
    testcases = root.findall("testcase") or [root]

    for idx, testcase in enumerate(testcases, start=1):
        scenario_name = testcase.get("name") or f"Scenario_{idx}"
        feature_name = "Generated Feature File"
        description = clean_html(testcase.findtext("summary") or testcase.text)
        testlink_url = ""

        preconditions_raw = testcase.findtext("preconditions")
        preconditions = clean_html(preconditions_raw)

        steps = []
        if preconditions.strip():
            steps.append({
                "keyword": "Given",
                "text": normalize_step_text(preconditions),
                "table": None
            })

        last_keyword = None
        for step in testcase.findall(".//step"):
            action_raw = step.findtext("actions")
            expected_raw = step.findtext("expectedresults")

            action = clean_html(action_raw)
            expected = clean_html(expected_raw)

            if action:
                keyword_action = "When" if last_keyword not in ["When", "And"] else "And"
                steps.append({
                    "keyword": keyword_action,
                    "text": normalize_step_text(action),
                    "table": None
                })
                last_keyword = keyword_action

            if expected:
                keyword_expected = "Then" if last_keyword not in ["Then", "And"] else "And"
                cleaned_text = expected.split("specifically:")[0] if "specifically:" in expected else expected
                steps.append({
                    "keyword": keyword_expected,
                    "text": normalize_step_text(cleaned_text),
                    "table": extract_tag_table(expected)
                })
                last_keyword = keyword_expected

        # Si aucun step n'est trouvé, ajouter un step générique
        if not steps:
            steps.append({
                "keyword": "Given",
                "text": "Generic step extracted from XML",
                "table": None
            })

        scenario = {
            "name": scenario_name,
            "steps": steps,
            "examples": None
        }

        context = {
            "feature_name": feature_name,
            "description": description,
            "testlink_url": testlink_url,
            "scenarios": [scenario]
        }

        # Générer un nom de fichier sûr
        base_name = scenario_name.replace(" ", "_").replace("?", "")[:50]
        safe_name = f"{base_name}.feature"
        i = 1
        while os.path.exists(os.path.join(output_dir, safe_name)):
            i += 1
            safe_name = f"{base_name}_{i}.feature"

        output_path = os.path.join(output_dir, safe_name)
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(template.render(**context))

        generated_files.append(output_path)

    return generated_files
