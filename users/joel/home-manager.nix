{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {

  imports = [ ../../modules/home-manager ];

  modules.firefox.enable = !isDarwin;
  modules.gnome.enable = isLinux;
  overrides.vscode.unfree = isDarwin;

}
