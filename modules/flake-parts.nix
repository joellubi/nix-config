{ inputs, ... }:
{
  # Enables the `flake.modules.<class>.<aspect>` option used throughout this
  # config (type: lazyAttrsOf (lazyAttrsOf deferredModule)).
  imports = [ inputs.flake-parts.flakeModules.modules ];

  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];
}
