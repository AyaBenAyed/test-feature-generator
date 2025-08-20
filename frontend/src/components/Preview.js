import React, { useState, useEffect, useMemo } from 'react';
import './Preview.css';

export default function Preview({ selectedFeature, features = [] }) {
  const [branchName, setBranchName] = useState('');
  const [commitMessage, setCommitMessage] = useState('');
  const [editMode, setEditMode] = useState(false);
  const [editableContent, setEditableContent] = useState('');

  // Échapper le HTML pour éviter l'injection
  const escapeHtml = (str) =>
    str
      .replaceAll(/&/g, '&amp;')
      .replaceAll(/</g, '&lt;')
      .replaceAll(/>/g, '&gt;');

  // Coloration syntaxique Gherkin
  const highlightGherkin = (text) => {
    const esc = escapeHtml(text);
    return esc
      .replace(/^Feature:.*$/gmi, '<span class="gherkin-feature">$&</span>')
      .replace(/^Scenario(?: Outline)?:.*$/gmi, '<span class="gherkin-scenario">$&</span>')
      .replace(/\bGiven\b/g, '<span class="gherkin-given">Given</span>')
      .replace(/\bWhen\b/g, '<span class="gherkin-when">When</span>')
      .replace(/\bThen\b/g, '<span class="gherkin-then">Then</span>')
      .replace(/\bAnd\b/g, '<span class="gherkin-and">And</span>')
      .replace(/\bBut\b/g, '<span class="gherkin-but">But</span>');
  };

  // Charger le contenu de la feature sélectionnée
  useEffect(() => {
    if (!selectedFeature) {
      setEditableContent('');
      return;
    }
    setEditableContent(selectedFeature.content || `Feature: ${selectedFeature.display_name}`);
  }, [selectedFeature]);

  // Contenu coloré recalculé en lecture
  const coloredContent = useMemo(() => highlightGherkin(editableContent || ''), [editableContent]);

  // Sauvegarder les modifications dans la feature sélectionnée
  const handleSave = () => {
    if (!selectedFeature) return alert('Aucune feature sélectionnée');
    selectedFeature.content = editableContent;
    alert(`Feature "${selectedFeature.display_name}" sauvegardée avec les modifications.`);
  };

  // Exporter une seule feature (téléchargement)
  const handleExport = () => {
    if (!selectedFeature) return alert('Aucune feature à exporter');
    const blob = new Blob([editableContent], { type: 'text/plain;charset=utf-8' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = selectedFeature.display_name + '.feature';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    alert(`Feature "${selectedFeature.display_name}" téléchargée.`);
  };

  // Exporter toutes les features (téléchargement séquentiel)
  const handleExportAll = async () => {
    if (!features || features.length === 0) {
      alert('Aucune feature à exporter.');
      return;
    }

    for (const feature of features) {
      const contentToExport =
        selectedFeature && feature.display_name === selectedFeature.display_name
          ? editableContent
          : feature.content || `Feature: ${feature.display_name}`;

      const blob = new Blob([contentToExport], { type: 'text/plain;charset=utf-8' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = feature.display_name + '.feature';
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      URL.revokeObjectURL(url);

      // Petit délai pour que le navigateur gère tous les clics
      await new Promise((resolve) => setTimeout(resolve, 100));
    }

    alert('Toutes les features téléchargées.');
  };

  // Commit Git + Request
  const handleCommitGit = async () => {
    if (!branchName || !commitMessage) return alert('Nom de branche et message de commit requis');
    try {
      const res = await fetch('http://127.0.0.1:5000/api/export-git', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ branch_name: branchName, commit_message: commitMessage }),
      });
      const data = await res.json();
      if (res.ok) alert(data.message || 'Commit Git effectué avec succès !');
      else alert(`Erreur : ${data.error}`);
    } catch (err) {
      console.error(err);
      alert('Erreur serveur lors du commit Git');
    }
  };

  return (
    <div className="preview">
      <h2>{selectedFeature ? selectedFeature.display_name : 'Aucune feature sélectionnée'}</h2>

      {selectedFeature && (
        <>
          {editMode ? (
            <textarea
              className="feature-editor"
              value={editableContent}
              onChange={(e) => setEditableContent(e.target.value)}
            />
          ) : (
            <pre
              className="gherkin-output"
              dangerouslySetInnerHTML={{ __html: coloredContent }}
            />
          )}

          <button className="btn-secondary" onClick={() => setEditMode(!editMode)}>
            {editMode ? "Quitter l'édition" : "Modifier"}
          </button>
        </>
      )}

      <div className="preview-actions">
        <div className="row">
          <button className="btn-secondary" onClick={handleSave}>Sauvegarder</button>
          <button className="btn-secondary" onClick={handleExport}>Exporter</button>
        </div>

        <div className="row">
          <input
            type="text"
            placeholder="Nom de la branche"
            value={branchName}
            onChange={(e) => setBranchName(e.target.value)}
          />
          <input
            type="text"
            placeholder="Message de commit"
            value={commitMessage}
            onChange={(e) => setCommitMessage(e.target.value)}
          />
          <button className="btn-primary" onClick={handleExportAll}>Exporter tout</button>
          <button className="btn-primary" onClick={handleCommitGit}>Commit Git + Request</button>
        </div>
      </div>
    </div>
  );
}
