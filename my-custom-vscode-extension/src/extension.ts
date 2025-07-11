// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import crypto from "crypto";
import fs from "fs";
import sqlite3 from "sqlite3";
import * as vscode from "vscode";

let db: sqlite3.Database;
// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
export async function activate(context: vscode.ExtensionContext) {
  // Create an output channel named "MyExtension"
  const outputChannel = vscode.window.createOutputChannel("MyExtension", {
    log: true,
  });
  const REF = vscode.workspace?.workspaceFolders?.[0]?.uri
    ?.toString()
    ?.replace("file://", "");
  const stats = fs.statSync(REF as string);
  const INO = stats.ino;
  const dataToHash = `${REF}${INO}`;
  const hash = crypto.createHash("md5").update(dataToHash).digest("hex");
  const dbPath = `/home/ronnas/.config/Code/User/workspaceStorage/${hash}/state.vscdb`;
  outputChannel.info('Extension "my-custom-vscode-extension" is now active!');
  outputChannel.info(`${dbPath}`);

  db = new sqlite3.Database(dbPath, sqlite3.OPEN_READONLY, (err) => {
    if (err) {
      outputChannel.error(`Failed to open database: ${err.message}`);
      return;
    }
    outputChannel.info("Connected to SQLite database.");
  });

  vscode.workspace.onDidOpenTextDocument((document) => {
    db?.close();
    db = new sqlite3.Database(dbPath, sqlite3.OPEN_READONLY, (err) => {
      if (err) {
        outputChannel.error(`Failed to open database: ${err.message}`);
        return;
      }
      outputChannel.info("Connected to SQLite database.");
    });
    db.all("SELECT * FROM itemTable;", [], (err, rows) => {
      if (err) {
        outputChannel.error(`Query error: ${err.message}`);
        return;
      }
      rows.forEach((row) => {
        if (row.key === "workbench.panel.wasLastMaximized") {
          outputChannel.info(`row: ${JSON.stringify(row.value)}`);
        }
        // if (row.key === "workbench.panel.hidden") {
        //   outputChannel.info(`row: ${JSON.stringify(row.value)}`);
        // }
      });
    });
    outputChannel.info(`LOG: ${hash} `);
    // if(!!document?.fileName && !document?.fileName?.includes('my-custom-vscode-extension')){
    //   outputChannel.info(`Document opened: ${document?.fileName} }`);
    //    vscode.commands.executeCommand('workbench.action.closePanel').then(()=>{
    //      outputChannel.info('Panel closed.');
    //    });
    //  }
  });
}

// This method is called when your extension is deactivated
export function deactivate() {
  db?.close();
}
