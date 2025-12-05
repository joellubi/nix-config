{ config, lib, pkgs, ... }:
{

  options = {};

  config = {

    home = {
      file = {
        ghostty = {
          source = ./dotfiles/ghostty;
          target = ".config/ghostty/config";
        };
      };
    };

  };

}
