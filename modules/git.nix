let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.git
      ];
    };
in
{
  flake.modules.nixos.programs = {
    imports = [ packages ];
  };
  flake.modules.darwin.programs = {
    imports = [ packages ];
  };
}
