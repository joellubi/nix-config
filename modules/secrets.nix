{ inputs, ... }:
let
  # Shared sops-nix base. Per-user secrets (email, gitconfig template) and the
  # age keyFile live in the user aspects, since they depend on the user's home.
  base = {
    sops = {
      defaultSopsFile = ../secrets.yaml;
      defaultSopsFormat = "yaml";
      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # TODO: Maybe need to change for darwin
        generateKey = true;
      };
    };
  };
in
{
  flake.modules.nixos.secrets = {
    imports = [
      inputs.sops-nix.nixosModules.sops
      base
    ];
  };
  flake.modules.darwin.secrets = {
    imports = [
      inputs.sops-nix.darwinModules.sops
      base
    ];
  };
}
