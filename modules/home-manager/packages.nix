{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in
{

  options = { };

  config = {

    #---------------------------------------------------------------------
    # Packages
    #---------------------------------------------------------------------

    home = {
      packages = [
        pkgs.curl
        pkgs.delve
        pkgs.docker-compose
        pkgs.duckdb
        pkgs.go
        pkgs.gotools
        pkgs.graphviz
        pkgs.grpcui
        pkgs.grpcurl
        pkgs.jq
        pkgs.just
        pkgs.kubectl
        pkgs.lf
        pkgs.mitmproxy
        pkgs.nixd
        pkgs.nixfmt-rfc-style
        pkgs.nmap
        pkgs.neovim
        pkgs.tree
        pkgs.vim
        pkgs.wget
        pkgs.wireguard-tools
        pkgs.youplot
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
