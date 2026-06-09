{ ... }:
{
  flake.modules.homeManager.dotfiles = {
    home.file = {
      ghostty = {
        source = ./dotfiles/ghostty;
        target = ".config/ghostty/config";
      };
      pi-agents = {
        source = ./dotfiles/pi-agent-AGENTS.md;
        target = ".pi/agent/AGENTS.md";
      };
    };
  };
}
