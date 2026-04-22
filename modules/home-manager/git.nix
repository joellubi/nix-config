{ config, lib, ... }:
with lib;
let
  cfg = config.modules.git;
in {

  options.modules.git = {
    name = mkOption { type = types.str; default = "Joel Lubinitsky"; };
  };

  config = {

    #---------------------------------------------------------------------
    # Programs
    #---------------------------------------------------------------------

    programs.git = {
      enable = true;
      settings = {
        user.name = cfg.name;
        init.defaultBranch = "main";
      };
      includes = [
        { path = "~/.config/secure/config.inc"; }
      ];
    };

  };

}
