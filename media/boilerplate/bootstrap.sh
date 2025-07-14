#!/usr/bin/env bash
set -e
mkdir -p data notebooks scripts models outputs .vscode
python -m venv .venv
source .venv/Scripts/activate
python -m pip install --upgrade pip
pip install numpy pandas matplotlib seaborn scikit-learn jupyter pytorch statsmodels xgboost lightgbm catboost plotly optuna
pip freeze > requirements.txt
echo '{"python.defaultInterpreterPath": "${workspaceFolder}/.venv/Scripts/python"}' > .vscode/settings.json
touch README.md main.py notebooks/EDA.ipynb .gitignore
echo ".venv/" >> .gitignore
echo "__pycache__/" >> .gitignore
echo ".ipynb_checkpoints/" >> .gitignore
echo "✅ Setup complete."
