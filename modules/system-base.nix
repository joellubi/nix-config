{ inputs, ... }:
let
  base =
    { pkgs, ... }:
    {
      programs.zsh.enable = true; # must be enabled at the system level for shell integrations to work
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      # Set Git commit hash of the top-level flake that built the configuration.
      system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    };
in
{
  flake.modules.nixos.system-base = base;
  flake.modules.darwin.system-base = base;
}
