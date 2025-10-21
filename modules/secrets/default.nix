{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.secrets;
in 
{
  options.modules.secrets = {
    user = mkOption { type = types.str; };
  };

  config = {
    sops = {
      defaultSopsFile = ../../secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/Users/${cfg.user}/Library/Application Support/sops/age/keys.txt"; # TODO: darwin-specific path

      secrets."${cfg.user}/email" = {};
    };
  };

}
