import React, { useState } from 'react';
import Sidebar from './components/Sidebar';
import Preview from './components/Preview';
import './App.css';

function App() {
  const [features, setFeatures] = useState([]);
  const [selectedFeature, setSelectedFeature] = useState(null);

  const toggleFeatureSelection = (id) => {
    setFeatures((prev) =>
      prev.map((f) =>
        f.id === id ? { ...f, selected: !f.selected } : f
      )
    );
  };

  const toggleSelectAll = () => {
    const allSelected = features.every((f) => f.selected);
    setFeatures((prev) =>
      prev.map((f) => ({ ...f, selected: !allSelected }))
    );
  };

  const allSelected = features.length > 0 && features.every((f) => f.selected);

  return (
    <div className="app-container">
      <Sidebar
        features={features}
        setFeatures={setFeatures}
        setSelectedFeature={setSelectedFeature}
        toggleFeatureSelection={toggleFeatureSelection}
        toggleSelectAll={toggleSelectAll}
        allSelected={allSelected}
      />
      <Preview selectedFeature={selectedFeature} features={features} />
    </div>
  );
}

export default App;
