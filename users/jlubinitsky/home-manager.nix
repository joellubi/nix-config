{ inputs, ... }:

{ config, lib, pkgs, ... }:

{

  imports =
    [
      ../../modules/home-manager/shell.nix
      # ./vscode.nix
    ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

}
