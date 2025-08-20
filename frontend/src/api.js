const API_URL = 'http://127.0.0.1:5000';

export async function uploadXML(file) {
  const formData = new FormData();
  formData.append('file', file);

  const res = await fetch(`${API_URL}/api/upload-xml`, {
    method: 'POST',
    body: formData
  });

  if (!res.ok) {
    const text = await res.text();
    throw new Error(`Erreur serveur: ${res.status} - ${text}`);
  }

  return res.json();
}

export async function fetchFeature(featureName) {
  const res = await fetch(`${API_URL}/api/features/${featureName}`);
  if (!res.ok) {
    throw new Error(`Feature introuvable : ${featureName}`);
  }
  return res.json();
}
