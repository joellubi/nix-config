{ lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      host = pkgs.stdenv.hostPlatform;
      package = if host.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
      wrapped = pkgs.writeShellScriptBin "ghostty" ''
        if (( $# == 0 )); then
            exec ${lib.getExe package} --config-file=${./config.ghostty}
        else
            exec ${lib.getExe package} "$@"
        fi
      '';
    in
    {
      packages.ghostty = pkgs.symlinkJoin {
        name = "ghostty";
        paths = [
          wrapped
          package
        ];
      };
    };
}
