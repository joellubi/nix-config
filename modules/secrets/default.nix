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
      age = {
        keyFile = "${config.users.users.${cfg.user}.home}/.config/sops/age/keys.txt";
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # TODO: Maybe need to change for darwin
        generateKey = true;
      };

      secrets."${cfg.user}/email" = {};
    };
  };

}
