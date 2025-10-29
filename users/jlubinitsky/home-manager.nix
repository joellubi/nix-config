{ inputs, machine, ... }:

{ config, lib, pkgs, ... }:

{

  imports =
    [
      ../../modules/home-manager/git.nix
      ../../modules/home-manager/just.nix
      ../../modules/home-manager/packages.nix
      ../../modules/home-manager/poetry.nix
      ../../modules/home-manager/shell.nix
    ];

  modules.just = { inherit machine; darwin = true; };

  home.packages = [
    pkgs.python311
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

}
