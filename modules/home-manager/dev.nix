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
      pkgs.go
      pkgs.google-cloud-sdk
      pkgs.gotools
      pkgs.graphviz
      pkgs.lf
      pkgs.nixd
      pkgs.tree
      pkgs.vim
      pkgs.wget
      pkgs.wireguard-tools
    ] ++ (lib.optionals isLinux [
      pkgs.xclip
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
    };


    programs.kitty = {
      enable = true;
      theme = "Space Gray Eighties";
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

  };

  # services.xremap = {
  #   withX11 = true;
  #   config = {
  #     modmap = [
  #       { remap = { "leftalt" = "leftctrl"; }; }
  #     ];
  #   };
  # };
}
