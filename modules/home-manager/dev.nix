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
    # Packages
    #---------------------------------------------------------------------

    home.packages = [
      pkgs.curl
      pkgs.delve
      pkgs.docker-compose
      pkgs.go
      pkgs.google-cloud-sdk
      pkgs.gotools
      pkgs.graphviz
      pkgs.jq
      pkgs.kubectl
      pkgs.lf
      pkgs.nixd
      pkgs.postgresql_16
      pkgs.redis
      pkgs.rustup
      pkgs.terraform
      pkgs.tree
      pkgs.vim
      pkgs.wget
      pkgs.wireguard-tools
      pkgs.yarn
    ] ++ (lib.optionals isLinux [
      pkgs.xclip
      pkgs.spotify
    ]);

    #---------------------------------------------------------------------
    # Env vars and dotfiles
    #---------------------------------------------------------------------

    home.sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      EDITOR = "vim";
      # PAGER = "less -FirSwX";
      # MANPAGER = "${manpager}/bin/manpager";
    };

    #---------------------------------------------------------------------
    # Programs
    #---------------------------------------------------------------------

    programs.git = {
      enable = true;
      userName = "Joel Lubinitsky";
      userEmail = "joellubi@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        # Homebrew
        if [ -d "/opt/homebrew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
      '';

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" ];
      };
    };


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


    programs.kitty = {
      enable = true;
      themeFile = "SpaceGray_Eighties";
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.poetry = {
      enable = true;
      settings = {
        virtualenvs.create = true;
        virtualenvs.in-project = true;
      };
    };

    programs.awscli = {
      enable = true;
    };

  };

}
