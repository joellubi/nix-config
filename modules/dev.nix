{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {

  options = {};

  config = {

    #---------------------------------------------------------------------
    # Packages
    #---------------------------------------------------------------------

    home.packages = [
      pkgs.go
      pkgs.gotools
      pkgs.delve
      pkgs.graphviz
      pkgs.nixd
    ];

    #---------------------------------------------------------------------
    # Env vars and dotfiles
    #---------------------------------------------------------------------

    # home.sessionVariables = {
    #   LANG = "en_US.UTF-8";
    #   LC_CTYPE = "en_US.UTF-8";
    #   LC_ALL = "en_US.UTF-8";
    #   EDITOR = "nvim";
    #   PAGER = "less -FirSwX";
    #   MANPAGER = "${manpager}/bin/manpager";
    # };

    #---------------------------------------------------------------------
    # Programs
    #---------------------------------------------------------------------

    # programs.gpg.enable = !isDarwin;

    # programs.direnv= {
    #   enable = true;

    #   config = {
    #     whitelist = {
    #       prefix= [
    #         "$HOME/code/go/src/github.com/hashicorp"
    #         "$HOME/code/go/src/github.com/mitchellh"
    #       ];

    #       exact = ["$HOME/.envrc"];
    #     };
    #   };
    # };


    programs.git = {
      enable = true;
      userName = "Joel Lubinitsky";
      userEmail = "joellubi@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
      # signing = {
      #   key = "523D5DC389D273BC";
      #   signByDefault = true;
      # };
      # aliases = {
      #   cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
      #   prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      #   root = "rev-parse --show-toplevel";
      # };
      # extraConfig = {
      #   branch.autosetuprebase = "always";
      #   color.ui = true;
      #   core.askPass = ""; # needs to be empty to use terminal for ask pass
      #   credential.helper = "store"; # want to make this more secure
      #   github.user = "mitchellh";
      #   push.default = "tracking";
      #   init.defaultBranch = "main";
      # };
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" ];
      };
    };


    programs.vscode = {
      enable = true;
      userSettings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
      };
      extensions = with pkgs.vscode-extensions; [
        eamodio.gitlens
        golang.go
        # arrterian.nix-env-selector
        jnoortheen.nix-ide
      ];
    };


    programs.kitty = {
      enable = true;
      theme = "Space Gray Eighties";
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

  # services.gpg-agent = {
  #   enable = isLinux;
  #   pinentryPackage = pkgs.pinentry-tty;

  #   # cache the keys forever so we don't get asked for a password
  #   defaultCacheTtl = 31536000;
  #   maxCacheTtl = 31536000;
  # };
}
