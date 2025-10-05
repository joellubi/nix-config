{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.just;
in {

  options.modules.just = {
    machine = mkOption { type = types.str; };
    darwin = mkEnableOption "darwin";
    flake-path = mkOption {
      type = types.str;
      default = "gitrepos/joellubi/nix-config";
    };
  };

  config = {

    home.file.justfile.text = ''
      config := "$HOME/${cfg.flake-path}#${cfg.machine}"
      system := "${if cfg.darwin then "darwin" else "nixos" }"

      dry-build:
        just dry-build-{{system}}

      switch:
        just switch-{{system}}

      dry-build-darwin:
        darwin-rebuild build --flake {{config}} --dry-run
      
      switch-darwin:
        sudo darwin-rebuild switch --flake {{config}}
      
      dry-build-nixos:
        sudo nixos-rebuild dry-build --flake {{config}}
      
      switch-nixos:
        sudo nixos-rebuild switch --flake {{config}}
    '';

  };

}
