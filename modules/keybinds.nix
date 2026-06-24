{ lib, ... }:
{
  flake.modules.nixos.keybinds = { }; # TODO
  flake.modules.darwin.keybinds =
    { pkgs, ... }:
    let
      package = pkgs.skhd;
      skhdConfig = pkgs.writeText "skhdrc" ''
        alt - b : open -a "Google Chrome"
        alt + shift - b : open -n -a "Google Chrome"

        alt - t : open -a ${pkgs.ghostty}/Applications/Ghostty.app
        alt + shift - t : open -na ${pkgs.ghostty}/Applications/Ghostty.app
      '';
    in
    {
      launchd.user.agents.skhd = {
        serviceConfig.ProgramArguments = [
          "${lib.getExe package}"
          "-c"
          "${skhdConfig}"
        ];
        serviceConfig.KeepAlive = true;
        serviceConfig.ProcessType = "Interactive";

        managedBy = "services.skhd.enable";
      };
    };
}
