{ lib, ... }:
{
  flake.modules.nixos.keybinds = { }; # TODO
  flake.modules.darwin.keybinds =
    { pkgs, ... }:
    let
      package = pkgs.skhd;
      skhdConfig = pkgs.writeText "skhdrc" ''
        fn - b : open -a "Google Chrome"
        fn + shift - b : open -n -a "Google Chrome"

        fn - t : open -a ${pkgs.ghostty}/Applications/Ghostty.app
        fn + shift - t : open -na ${pkgs.ghostty}/Applications/Ghostty.app
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
