{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./gnome.nix
    ./firefox.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "joel";
  home.homeDirectory = "/home/joel";
}

