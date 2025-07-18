#!/usr/bin/env bash
set -ex

uv init --yes

mkdir -p data notebooks scripts models outputs .vscode

uv venv
uv pip install numpy pandas matplotlib seaborn scikit-learn jupyter statsmodels xgboost lightgbm plotly optuna ipykernel
uv pip compile --all --output requirements.lock

if [[ "$OSTYPE" == "darwin"* || "$OSTYPE" == "linux-gnu"* ]]; then
    echo '{"python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python"}' > .vscode/settings.json
else
    echo '{"python.defaultInterpreterPath": "${workspaceFolder}/.venv/Scripts/python"}' > .vscode/settings.json
fi

python -m ipykernel install --user --name="$(basename "$PWD")" --display-name="$(basename "$PWD")"

touch README.md main.py notebooks/nb.ipynb .gitignore

for pattern in \
    ".venv/" \
    "__pycache__/" \
    ".ipynb_checkpoints/"; do
  grep -qxF "$pattern" .gitignore || echo "$pattern" >> .gitignore
done

echo "✅ Setup complete."
