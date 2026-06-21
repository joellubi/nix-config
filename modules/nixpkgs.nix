{ inputs, ... }:
let
  # Overlays applied to every system's nixpkgs. neovim and zig are built once
  # as flake packages (see modules/packages/) and injected here so we don't
  # rebuild them per host.
  overlay = final: prev: {
    neovim = inputs.self.packages.${prev.stdenv.hostPlatform.system}.neovim;
    zig = inputs.self.packages.${prev.stdenv.hostPlatform.system}.zig;
    ghostty = inputs.self.packages.${prev.stdenv.hostPlatform.system}.ghostty;
    nh = inputs.self.packages.${prev.stdenv.hostPlatform.system}.nh;
    direnv = prev.direnv.overrideAttrs (_: {
      doCheck = false;
    });
    pi-coding-agent =
      inputs.nixpkgs-unstable.legacyPackages.${prev.stdenv.hostPlatform.system}.pi-coding-agent;
    #go = inputs.nixpkgs-unstable.legacyPackages.${prev.stdenv.hostPlatform.system}.go_1_25;
  };

  nixpkgs = {
    nixpkgs.overlays = [ overlay ];
    nixpkgs.config.allowUnfree = true;
  };
in
{
  flake.modules.nixos.nixpkgs = nixpkgs;
  flake.modules.darwin.nixpkgs = nixpkgs;
}
