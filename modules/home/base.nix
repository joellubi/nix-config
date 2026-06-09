{ config, ... }:
{
  # The home-manager config common to every user. Per-user aspects
  # (home/joel.nix, home/jlubinitsky.nix) import this and add their extras.
  flake.modules.homeManager.base = {
    imports = with config.flake.modules.homeManager; [
      dotfiles
      git
      just
      packages
      poetry
      shell
    ];

    # Home-manager 22.11 requires this be set. We never set it so we have
    # to use the old state version.
    home.stateVersion = "23.11";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
