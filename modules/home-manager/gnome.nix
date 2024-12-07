{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.gnome;
in {

  options.modules.gnome = {
    enable = mkEnableOption "gnome";
  };

  config = mkIf cfg.enable {
    programs.gnome-shell = {
      enable = true;
      extensions = [
        { package = pkgs.gnomeExtensions.vitals; }
      ];
    };
  };

}
