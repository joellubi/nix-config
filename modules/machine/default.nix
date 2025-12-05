{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.zsh.enable = true; # must be enabled at the system level for shell integrations to work
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
