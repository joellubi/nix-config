{ ... }:
{
  flake.modules.homeManager.packages =
    { lib, pkgs, ... }:
    let
      isLinux = pkgs.stdenv.isLinux;
      isDarwin = pkgs.stdenv.isDarwin;
    in
    {
      home = {
        packages = [
          pkgs.curl
          pkgs.delve
          pkgs.docker-compose
          pkgs.duckdb
          pkgs.go
          pkgs.gotools
          pkgs.grpcui
          pkgs.grpcurl
          pkgs.jq
          pkgs.just
          pkgs.mitmproxy
          pkgs.nixd
          pkgs.nixfmt-rfc-style
          pkgs.neovim
          pkgs.oauth2c
          pkgs.pi-coding-agent
          pkgs.tree
          pkgs.wget
          pkgs.wireguard-tools
          pkgs.youplot
          pkgs.zig
        ]
        ++ (lib.optionals isLinux [
          pkgs.xclip
          pkgs.spotify
          pkgs.ghostty
        ])
        ++ (lib.optionals isDarwin [
          pkgs.iproute2mac
        ]);
        shellAliases = {
          k = "sudo k3s kubectl";
        };
      };
    };
}
