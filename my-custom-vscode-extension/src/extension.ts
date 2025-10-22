import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
  let disposable = vscode.commands.registerCommand('extension.listOpenTextFiles', async () => {
    const openFiles: string[] = [];
    vscode.window.tabGroups.all.forEach(group => {
      group.tabs.forEach(tab => {
        if (tab.input instanceof vscode.TabInputText) {
          openFiles.push((tab.input as vscode.TabInputText).uri.fsPath);
        }
      });
    });
    const fileList = openFiles.join('\n');
    await vscode.env.clipboard.writeText(fileList);
    vscode.window.showInformationMessage(`Arquivos de texto abertos copiados para o clipboard: ${openFiles.join(', ')}`);
  });
  context.subscriptions.push(disposable);



}
