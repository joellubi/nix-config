{ inputs, ... }:

{ pkgs, ... }:

{
  imports = [ inputs.xremap-flake.nixosModules.default ];

  services.xremap = {
    enable = true;
    withX11 = true;
    config = {
      modmap = [
        {
          remap = {
            "CapsLock" = "LeftMeta";
            "LeftMeta" = "LeftAlt";
            "LeftAlt" = "LeftCtrl";
          };
        }
      ];
      keymap = [
        {
          remap = {
            "Ctrl-Left" = "Home";
            "Ctrl-Right" = "End";
            "Shift-Ctrl-Left" = "Shift-Home";
            "Shift-Ctrl-Right" = "Shift-End";
            "Alt-Left" = "Ctrl-Left";
            "Alt-Right" = "Ctrl-Right";
            "Alt-Backspace" = "Ctrl-Backspace";
          };
        }
      ];
    };
  };

  users.users.joel = {
    isNormalUser = true;
    home = "/home/joel";
    description = "Joel Lubinitsky";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}
