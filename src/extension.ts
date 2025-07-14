import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';
import { exec } from 'child_process';

function copyRecursiveSync(src: string, dest: string) {
  if (!fs.existsSync(dest)) fs.mkdirSync(dest);
  fs.readdirSync(src).forEach(item => {
    const srcPath = path.join(src, item);
    const destPath = path.join(dest, item);
    if (fs.lstatSync(srcPath).isDirectory()) {
      copyRecursiveSync(srcPath, destPath);
    } else {
      fs.copyFileSync(srcPath, destPath);
    }
  });
}

export function activate(context: vscode.ExtensionContext) {
  const disposable = vscode.commands.registerCommand('extension.createDSProject', async () => {
    const folderUri = await vscode.window.showOpenDialog({
      canSelectFolders: true,
      openLabel: 'Select folder to create project in'
    });

    if (!folderUri || folderUri.length === 0) return;

    const projectName = await vscode.window.showInputBox({
      prompt: 'Enter project name',
      placeHolder: 'my-ds-project'
    });

    if (!projectName) return;

    const parentPath = folderUri[0].fsPath;
    const projectPath = path.join(parentPath, projectName);

    fs.mkdirSync(projectPath);

    const boilerplatePath = path.join(context.extensionPath, 'media', 'boilerplate');
    copyRecursiveSync(boilerplatePath, projectPath);

    const bootstrapPath = path.join(projectPath, 'bootstrap.sh').replace(/\\/g, '/');
    const bashCommand = `"C:\\Program Files\\Git\\bin\\bash.exe" "${bootstrapPath}"`;

    exec(bashCommand, { cwd: projectPath }, (err, stdout, stderr) => {
      if (err) {
        vscode.window.showErrorMessage(`Error: ${stderr}`);
      } else {
        vscode.window.showInformationMessage(`${projectName} created and bootstrapped.`);
        vscode.commands.executeCommand('vscode.openFolder', vscode.Uri.file(projectPath));
      }
    });
  });

  context.subscriptions.push(disposable);
}

export function deactivate() {}
