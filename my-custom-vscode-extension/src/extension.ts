import * as vscode from "vscode";

export function activate(context: vscode.ExtensionContext) {
  // Command 1: Copy full (absolute) paths
  let copyFullPaths = vscode.commands.registerCommand(
    "extension.copyFullPathOpenTextFiles",
    async () => {
      const openFiles: string[] = [];
      vscode.window.tabGroups.all.forEach((group) => {
        group.tabs.forEach((tab) => {
          if (tab.input instanceof vscode.TabInputText) {
            openFiles.push("@" + (tab.input as vscode.TabInputText).uri.fsPath);
          }
        });
      });
      const fileList = openFiles.join("\n");
      await vscode.env.clipboard.writeText(fileList);
      vscode.window.showInformationMessage(
        `Arquivos de texto abertos copiados para o clipboard: ${openFiles.join(", ")}`,
      );
    },
  );

  // Command 2: Copy relative paths
  let copyRelativePaths = vscode.commands.registerCommand(
    "extension.copyRelativePathOpenTextFiles",
    async () => {
      const workspaceFolders = vscode.workspace.workspaceFolders;

      const openFiles: string[] = [];
      vscode.window.tabGroups.all.forEach((group) => {
        group.tabs.forEach((tab) => {
          if (tab.input instanceof vscode.TabInputText) {
            const uri = (tab.input as vscode.TabInputText).uri;

            // Try to get the relative path within the workspace
            let relativePath: string;
            if (workspaceFolders && workspaceFolders.length > 0) {
              relativePath = vscode.workspace.asRelativePath(
                uri,
                workspaceFolders.length > 1,
              );
            } else {
              // Fallback to absolute path if no workspace is open
              relativePath = uri.fsPath;
            }

            openFiles.push("@" + relativePath);
          }
        });
      });

      const fileList = openFiles.join("\n");
      await vscode.env.clipboard.writeText(fileList);
      vscode.window.showInformationMessage(
        `Caminhos relativos copiados para o clipboard: ${openFiles.join(", ")}`,
      );
    },
  );

  context.subscriptions.push(copyFullPaths, copyRelativePaths);
}
