{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {

  imports = [ ../../modules/home-manager ];

  modules.firefox.enable = !isDarwin;
  overrides.vscode.unfree = isDarwin;

  programs.gnome-shell = {
    enable = isLinux;
    extensions = [
      { package = pkgs.gnomeExtensions.vitals; }
    ];
  };
}
