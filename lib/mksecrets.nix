user:
{ config, ... }:
{
  imports = [
    ../modules/secrets
  ];

  # User-specific secrets are nested under the user key in secrets.yaml
  modules.secrets.user = user;

  # Create "include" file with private data for primary git config to reference.
  sops.templates.gitconfig = {
    owner = config.users.users.${user}.name;
    path = "${config.users.users.${user}.home}/.config/secure/config.inc";
    content = ''
    [user]
            email = "${config.sops.placeholder."${user}/email"}"
    '';
  };
}
