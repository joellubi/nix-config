{ inputs, ... }:

{ pkgs, ... }:

{
  imports = [ inputs.xremap-flake.nixosModules.default ];

  services.xremap = {
    enable = true;
    withX11 = true;
    config = {
      modmap = [
        { remap = { "CapsLock" = "Esc"; }; }
      ];
    };
  };

  users.users.joel = {
    isNormalUser = true;
    home = "/home/joel";
    description = "Joel Lubinitsky";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}
