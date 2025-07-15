# Create Data Science Project

A simple VSCode extension to scaffold a new data science project with one command.

## Features

- Adds a command: `Create New Data Science Project`
- Prompts for:
  - Destination folder
  - Project name
- Copies a bundled boilerplate template
- Runs `bootstrap.sh` to:
  - Create standard subfolders
  - Set up a Python virtual environment
  - Install common data science packages
- Opens the new project in VSCode

## Usage

1. Press `Ctrl+Shift+P` and run `Create New Data Science Project`
2. Select the parent directory
3. Enter a project name
4. The extension will:
   - Create the folder
   - Copy files
   - Run `bootstrap.sh` using Git Bash
   - Open the project folder

## Requirements

- uv installed, see https://github.com/astral-sh/uv#installation
- For Windows, Git Bash (installed via Git for Windows)
- Or just Bash if not on Windows
- Python installed and accessible via Git Bash or Bash

## Included Tools

- Python virtualenv setup
- Preinstalled packages: `numpy`, `pandas`, `matplotlib`, `seaborn`, `scikit-learn`, `jupyter`, `statsmodels`, `xgboost`, `lightgbm`, `plotly`, `optuna`
- Auto-generated: `.vscode/settings.json`, `tasks.json`, `.gitignore`, `README.md`, `main.py`, `notebooks/scratch.ipynb`

## Notes

- The extension bundles all boilerplate files inside `media/boilerplate`
- Uses `bash.exe` from Git to execute `bootstrap.sh`

## License

MIT
