{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {

  imports = [ ../../modules ];

  home.username = "jlubinitsky";
  home.homeDirectory = "/Users/jlubinitsky";

  overrides.vscode.package = pkgs.vscode;
}
