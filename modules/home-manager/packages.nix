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
        pkgs.awscli2
        pkgs.curl
        pkgs.delve
        pkgs.docker-compose
        pkgs.duckdb
        pkgs.go
        pkgs.google-cloud-sdk
        pkgs.gotools
        pkgs.graphviz
        pkgs.grpcurl
        pkgs.jq
        pkgs.just
        pkgs.kubectl
        pkgs.lf
        pkgs.nixd
        pkgs.nixfmt-rfc-style
        pkgs.nmap
        pkgs.neovim
        pkgs.postgresql_16
        pkgs.redis
        pkgs.rustup
        pkgs.terraform
        pkgs.tree
        pkgs.typescript
        pkgs.vim
        pkgs.wget
        pkgs.wireguard-tools
        pkgs.yarn
        pkgs.youplot
      ]
      ++ (lib.optionals isLinux [
        pkgs.xclip
        pkgs.spotify
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
