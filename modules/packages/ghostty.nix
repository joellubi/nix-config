{ ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      host = pkgs.stdenv.hostPlatform;
      package = if host.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    in
    {
      packages.ghostty = package;
    };
}
