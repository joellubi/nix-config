{ config, pkgs, ... }:

{
  programs.gnome-shell = {
    enable = true;
    extensions = [
      { package = pkgs.gnomeExtensions.vitals; }
    ];
  };
}
