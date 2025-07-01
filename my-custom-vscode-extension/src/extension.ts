// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';

// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {
  // Create an output channel named "MyExtension"
  const outputChannel = vscode.window.createOutputChannel("MyExtension",{log: true});
  
  outputChannel.info('Extension "my-custom-vscode-extension" is now active!');

  vscode.workspace.onDidOpenTextDocument((document) => {
    if(!!document?.fileName && !document?.fileName?.includes('my-custom-vscode-extension')){
      outputChannel.info(`Document opened: ${document?.fileName} }`);
       vscode.commands.executeCommand('workbench.action.closePanel').then(()=>{
         outputChannel.info('Panel closed.');
       });
     }
  });

  outputChannel.show();
}

// This method is called when your extension is deactivated
export function deactivate() {}
