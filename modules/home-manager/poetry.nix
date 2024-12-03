{ config, lib, pkgs, ... }:
with lib; {

  options = {};

  config = {

    #---------------------------------------------------------------------
    # Programs
    #---------------------------------------------------------------------

    programs.poetry = {
      enable = true;
      settings = {
        virtualenvs.create = true;
        virtualenvs.in-project = true;
      };
    };

  };

}
