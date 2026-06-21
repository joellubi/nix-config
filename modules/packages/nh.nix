{ config, lib, ... }:
{
  options = {
    base.nh.flake-path = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/gitrepos/joellubi/nix-config";
      description = "Path to flake.";
    };
  };

  config.perSystem =
    { pkgs, ... }:
    let
      cfg = config.base.nh;
      package = pkgs.nh;
      wrapped = pkgs.writeShellScriptBin "nh" ''
        export NH_FLAKE="${cfg.flake-path}"
        exec ${lib.getExe package} "$@"
      '';
    in
    {
      packages.nh = pkgs.symlinkJoin {
        name = "nh";
        paths = [
          wrapped
          package
        ];
      };
    };
}
