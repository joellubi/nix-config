{ inputs, ... }:

{ config, lib, pkgs, ... }:

{

  imports =
    [
      ../../modules/home-manager/shell.nix
      ../../modules/home-manager/packages.nix
    ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

}
