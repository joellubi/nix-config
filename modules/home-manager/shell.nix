{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{

  options = { };

  config = {

    #---------------------------------------------------------------------
    # Env vars and dotfiles
    #---------------------------------------------------------------------

    home.sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      EDITOR = "vim";
      KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
      # PAGER = "less -FirSwX";
      # MANPAGER = "${manpager}/bin/manpager";
    };

    #---------------------------------------------------------------------
    # Programs
    #---------------------------------------------------------------------

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        # Homebrew
        if [ -d "/opt/homebrew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
      '';

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" ];
      };
    };

    programs.kitty = {
      enable = true;
      themeFile = "SpaceGray_Eighties";
      settings = {
        "mouse_map left" = "click ungrabbed";
        "mouse_map cmd+left" = "click ungrabbed mouse_click_url";
      };
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

  };

}
