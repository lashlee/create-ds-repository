#!/usr/bin/env bash
set -ex

mkdir -p data notebooks scripts models outputs .vscode
uv venv
uv pip install numpy pandas matplotlib seaborn scikit-learn jupyter statsmodels xgboost lightgbm plotly optuna
uv pip freeze > requirements.txt

if [[ "$OSTYPE" == "darwin"* || "$OSTYPE" == "linux-gnu"* ]]; then
    echo '{"python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python"}' > .vscode/settings.json
else
    echo '{"python.defaultInterpreterPath": "${workspaceFolder}/.venv/Scripts/python"}' > .vscode/settings.json
fi

touch README.md main.py notebooks/scratch.ipynb .gitignore

for pattern in \
    ".venv/" \
    "__pycache__/" \
    ".ipynb_checkpoints/"; do
  grep -qxF "$pattern" .gitignore || echo "$pattern" >> .gitignore
done

echo "✅ Setup complete."
