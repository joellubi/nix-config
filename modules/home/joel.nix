{ config, ... }:
{
  flake.modules.homeManager.joel =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        base
        aws
        firefox
        gnome
      ];

      modules.firefox.enable = pkgs.stdenv.isLinux;
      modules.gnome.enable = pkgs.stdenv.isLinux;
    };
}
