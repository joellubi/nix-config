{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {

  imports = [ ../../modules ];

  modules.firefox.enable = true;
  overrides.vscode.unfree = isDarwin;

  programs.gnome-shell = {
    enable = isLinux;
    extensions = [
      { package = pkgs.gnomeExtensions.vitals; }
    ];
  };

  # programs.git = {
  #   enable = true;
  #   userName = "Joel Lubinitsky";
  #   userEmail = "joellubi@gmail.com";
  #   extraConfig = {
  #     init.defaultBranch = "main";
  #   };
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
  # };

  # programs.kitty = {
  #   enable = !isWSL;
  #   extraConfig = builtins.readFile ./kitty;
  # };

  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscodium;
  #   userSettings = {
  #     "nix.enableLanguageServer" = true;
  #     "nix.serverPath" = "nixd";
  #   };
  #   extensions = with pkgs.vscode-extensions; [
  #     eamodio.gitlens
  #     golang.go
  #     # arrterian.nix-env-selector
  #     jnoortheen.nix-ide
  #   ];
  # };

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
