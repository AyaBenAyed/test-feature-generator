import React, { useRef } from 'react';
import './Sidebar.css';
import { uploadXML } from '../api';

function Sidebar({
  features,
  setFeatures,
  setSelectedFeature,
  toggleFeatureSelection,
  toggleSelectAll,
  allSelected
}) {
  const fileRef = useRef(null);

  const handleChooseFile = () => fileRef.current?.click();

  const handleFileChange = async (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    try {
      const result = await uploadXML(file);
      console.log("Réponse backend :", result);

      if (Array.isArray(result.features)) {
        setFeatures(result.features.map((f, idx) => ({
         id: idx, // index suffit si backend ne fournit pas d'ID unique
         display_name: f.display_name || f.name || `Feature ${idx + 1}`, // nom réel du fichier ou fallback
         content: f.content || '',
         selected: false
      })));
      } else {
        setFeatures([]);
}
    } catch (err) {
      console.error(err);
      alert("Échec de l'upload du XML");
    } finally {
      e.target.value = '';
    }
  };

  return (
    <div className="sidebar">
      <div className="upload-row">
        <button className="btn-primary" onClick={handleChooseFile}>
          + Ajouter un fichier XML
        </button>
        <input
          ref={fileRef}
          type="file"
          accept=".xml"
          className="hidden-input"
          onChange={handleFileChange}
        />
      </div>

      <div className="selection-controls">
        <label>
          <input type="checkbox" checked={!!allSelected} onChange={toggleSelectAll} />
          Tout sélectionner
        </label>
      </div>

      <div className="feature-list">
        {features.length === 0 ? (
          <div className="empty-features">
            <p>Aucune feature générée. Importez un fichier XML pour commencer.</p>
          </div>
        ) : (
          features.map((feature, index) => (
            <div
              key={`feature-${feature.id ?? index}`}
              className="feature-item"
              onClick={() => setSelectedFeature(feature)}
            >
              <div className="feature-header">
                <input
                  type="checkbox"
                  checked={!!feature.selected}
                  onChange={() => toggleFeatureSelection(feature.id)}
                  onClick={(e) => e.stopPropagation()}
                />
                <strong>{feature.display_name}</strong>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
}

export default Sidebar;
