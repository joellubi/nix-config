{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.sops
          pkgs.age
          pkgs.ssh-to-age
        ];

        shellHook = ''
          export SOPS_AGE_KEY_FILE=$HOME/.config/sops/age/keys.txt
        '';
      };
    };
}
