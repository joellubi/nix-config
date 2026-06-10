let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.nh
      ];
    };

  NH_FLAKE = "$HOME/gitrepos/joellubi/nix-config";
in
{
  flake.modules.nixos.programs = {
    imports = [ packages ];
    environment.sessionVariables = { inherit NH_FLAKE; };
  };
  flake.modules.darwin.programs = {
    imports = [ packages ];
    environment.variables = { inherit NH_FLAKE; };
  };
}
