{ lib, ... }:
{
  # flake-parts ships an option for `nixosConfigurations` but not
  # `darwinConfigurations`. Declare it so multiple host modules
  # (panther.nix, yeti.nix) can each contribute entries that merge.
  options.flake.darwinConfigurations = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.unspecified;
    default = { };
  };
}
