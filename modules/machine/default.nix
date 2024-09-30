{ config, lib, pkgs, ... }:
{
  programs.zsh.enable = true; # must be enabled at the system level for all integrations to work
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
