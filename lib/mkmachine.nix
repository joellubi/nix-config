name:
{ config, lib, pkgs, ... }:
let fs = lib.fileset;
in
{
  imports = fs.toList (
              fs.unions [
                ../machines/${name}/configuration.nix
                (fs.maybeMissing ../machines/${name}/hardware-configuration.nix)
              ]
            );
}
