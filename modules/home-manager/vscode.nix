{ config, lib, pkgs, ... }:
with lib;
let
  isLinux = pkgs.stdenv.isLinux;
in {

  options = {
    overrides.vscode.unfree = mkEnableOption "unfree vscode binary";
  };

  config = {

    #---------------------------------------------------------------------
    # Programs
    #---------------------------------------------------------------------

    home.shellAliases.code = if config.overrides.vscode.unfree then "code" else "codium";
    programs.vscode = {
      enable = true;
      package = if config.overrides.vscode.unfree then pkgs.vscode else pkgs.vscodium;
      userSettings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
      };
      extensions = with pkgs.vscode-extensions; [
        eamodio.gitlens
        golang.go
        jnoortheen.nix-ide
        ms-python.python
        ms-pyright.pyright
        mkhl.direnv
        ms-vscode.cpptools-extension-pack
      ];
      keybindings = (
        lib.optionals isLinux [
          {
            key = "shift+alt+up";
            command = "editor.action.copyLinesUpAction";
            when = "editorTextFocus && !editorReadonly";
          }
          {
            key = "shift+alt+down";
            command = "editor.action.copyLinesDownAction";
            when = "editorTextFocus && !editorReadonly";
          }
          {
            key = "ctrl+c";
            command = "workbench.action.terminal.copySelection";
            when = "terminalTextSelectedInFocused || terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected || terminalFocus && terminalTextSelected && terminalTextSelectedInFocused || terminalHasBeenCreated && terminalTextSelected && terminalTextSelectedInFocused || terminalProcessSupported && terminalTextSelected && terminalTextSelectedInFocused";
          }
          {
            key = "ctrl+v";
            command = "workbench.action.terminal.paste";
            when = "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
          }
          {
            key = "ctrl+backspace";
            command = "deleteAllLeft";
          }
        ]
      );
    };

  };

}
