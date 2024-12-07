{ config, lib, pkgs, ... }:

{

  imports =
    [
      ./aws.nix
      ./firefox.nix
      ./git.nix
      ./gnome.nix
      ./packages.nix
      ./poetry.nix
      ./shell.nix
      ./vscode.nix
    ];

  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
