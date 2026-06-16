let
  packages =
    { pkgs, ... }:
    {
      # TODO: Bring into wrapped package and move to user scope
      environment.systemPackages = [
        pkgs.nh
      ];
    };
in
{ config, lib, ... }:
{
  options = {
    base.nh.flake-path = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/gitrepos/joellubi/nix-config";
      description = "Path to flake.";
    };
  };

  config =
    let
      cfg = config.base.nh;
      NH_FLAKE = cfg.flake-path;
    in
    {
      flake.modules.nixos.base = {
        imports = [ packages ];
        environment.sessionVariables = { inherit NH_FLAKE; };
      };
      flake.modules.darwin.base = {
        imports = [ packages ];
        environment.variables = { inherit NH_FLAKE; };
      };
    };

}
