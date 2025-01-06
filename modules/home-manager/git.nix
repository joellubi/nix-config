{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.git;
in {

  options.modules.git = {
    name = mkOption { type = types.str; default = "Joel Lubinitsky"; };
    email = mkOption { type = types.str; default = "joellubi@gmail.com"; };
  };

  config = {

    #---------------------------------------------------------------------
    # Programs
    #---------------------------------------------------------------------

    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

  };

}
