{ inputs, ... }:

{ pkgs, ... }:

{
  users.users.joel = {
    isNormalUser = true;
    home = "/home/joel";
    description = "Joel Lubinitsky";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}
