{ config, lib, pkgs, ... }:
with lib;
let
  isLinux = pkgs.stdenv.isLinux;
in {

  options = {};

  config = {

    #---------------------------------------------------------------------
    # Packages
    #---------------------------------------------------------------------

    home.packages = [
      pkgs.curl
      pkgs.delve
      pkgs.docker-compose
      pkgs.duckdb
      pkgs.go
      pkgs.google-cloud-sdk
      pkgs.gotools
      pkgs.graphviz
      pkgs.jq
      pkgs.just
      pkgs.kubectl
      pkgs.lf
      pkgs.nixd
      pkgs.postgresql_16
      pkgs.redis
      pkgs.rustup
      pkgs.terraform
      pkgs.tree
      pkgs.vim
      pkgs.wget
      pkgs.wireguard-tools
      pkgs.yarn
    ] ++ (lib.optionals isLinux [
      pkgs.xclip
      pkgs.spotify
    ]);

  };

}
