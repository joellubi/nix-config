{ inputs, ... }:

{ config, lib, pkgs, ... }:

{

  imports =
    [
      ./shell.nix
      # ./vscode.nix
    ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

}
