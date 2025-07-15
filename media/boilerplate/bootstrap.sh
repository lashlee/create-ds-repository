#!/usr/bin/env bash
set -ex
mkdir -p data notebooks scripts models outputs .vscode
uv venv .venv
source .venv/Scripts/activate
uv pip install numpy pandas matplotlib seaborn scikit-learn jupyter statsmodels xgboost lightgbm plotly optuna
uv pip freeze > requirements.txt
echo '{"python.defaultInterpreterPath": "${workspaceFolder}/.venv/Scripts/python"}' > .vscode/settings.json
touch README.md main.py notebooks/scratch.ipynb .gitignore
echo ".venv/" >> .gitignore
echo "__pycache__/" >> .gitignore
echo ".ipynb_checkpoints/" >> .gitignore
echo "✅ Setup complete."
