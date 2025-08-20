# app.py
from flask import Flask, request, jsonify
import os
import uuid
from generator import generate_features
from git_helper import commit_to_git  # facultatif si tu veux gérer Git
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Configuration des dossiers
UPLOAD_FOLDER = 'uploads'
OUTPUT_FOLDER = 'output_features'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(OUTPUT_FOLDER, exist_ok=True)

@app.route('/api/upload-xml', methods=['POST'])
def upload_xml():
    if 'file' not in request.files:
        return jsonify({'error': 'Aucun fichier fourni'}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'Aucun fichier sélectionné'}), 400

    if not file.filename.lower().endswith('.xml'):
        return jsonify({'error': 'Type de fichier invalide. Seuls les fichiers XML sont acceptés.'}), 400

    # Sauvegarde du fichier XML
    filename = f"{uuid.uuid4()}.xml"
    file_path = os.path.join(UPLOAD_FOLDER, filename)
    file.save(file_path)

    # Génération des fichiers .feature
    try:
        features = generate_features(file_path, OUTPUT_FOLDER)
    except Exception as e:
        return jsonify({'error': f'Erreur lors de la génération des features : {e}'}), 500
    
    # 🔥 Lire le contenu de chaque fichier généré et le renvoyer
    feature_data = []
    for idx, f in enumerate(features, start=1):
        with open(f, "r", encoding="utf-8") as fp:
            content = fp.read()
        feature_data.append({
            "id": idx,
            "display_name": os.path.basename(f),
            "content": content
        })

    return jsonify({
        "message": "Features générées avec succès",
        "features": feature_data
    })

@app.route('/api/export-git', methods=['POST'])
def export_git():
    data = request.json
    branch_name = data.get('branch_name')
    commit_message = data.get('commit_message')

    if not branch_name or not commit_message:
        return jsonify({'error': 'Paramètres manquants : branch_name et commit_message requis.'}), 400

    try:
        result = commit_to_git(OUTPUT_FOLDER, branch_name, commit_message)
    except Exception as e:
        return jsonify({'error': f'Erreur lors du commit Git : {e}'}), 500

    if result.get('success'):
        return jsonify({'message': 'Commit Git réussi'})
    else:
        return jsonify({'error': result.get('error')}), 500

@app.route('/api/features/<feature_name>', methods=['GET'])
def get_feature(feature_name):
    feature_path = os.path.join(OUTPUT_FOLDER, feature_name)
    if not os.path.exists(feature_path):
        return jsonify({'error': 'Feature introuvable'}), 404

    with open(feature_path, 'r', encoding='utf-8') as f:
        content = f.read()

    return jsonify({
        'name': feature_name,
        'content': content
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
