import os
import subprocess

def commit_to_git(features_dir, branch_name, commit_message):
    try:
        repo_path = os.path.abspath(features_dir)
        
        # Commandes Git
        commands = [
            f"git checkout -b {branch_name}",
            "git add .",
            f"git commit -m '{commit_message}'",
            f"git push origin {branch_name}"
        ]
        
        # Exécution des commandes
        for cmd in commands:
            result = subprocess.run(
                cmd, 
                cwd=repo_path,
                shell=True,
                capture_output=True,
                text=True
            )
            if result.returncode != 0:
                return {
                    'success': False,
                    'error': f"Erreur Git: {result.stderr}"
                }
        
        return {'success': True}
    
    except Exception as e:
        return {
            'success': False,
            'error': str(e)
        }