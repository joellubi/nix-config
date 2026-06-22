{ config, inputs, ... }:
let
  inherit (config.flake.modules) nixos homeManager;
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations.baboon = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ./_baboon-hardware.nix
      nixos.pc
      nixos.joel
      {
        networking.hostName = "baboon";

        # Bootloader.
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        # Networking.
        networking.networkmanager.enable = true;

        # Time zone and locale.
        time.timeZone = "America/New_York";
        i18n.defaultLocale = "en_US.UTF-8";
        i18n.extraLocaleSettings = {
          LC_ADDRESS = "en_US.UTF-8";
          LC_IDENTIFICATION = "en_US.UTF-8";
          LC_MEASUREMENT = "en_US.UTF-8";
          LC_MONETARY = "en_US.UTF-8";
          LC_NAME = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_PAPER = "en_US.UTF-8";
          LC_TELEPHONE = "en_US.UTF-8";
          LC_TIME = "en_US.UTF-8";
        };

        # GNOME desktop on X11.
        services.xserver.enable = true;
        services.xserver.displayManager.gdm.enable = true;
        services.xserver.desktopManager.gnome.enable = true;
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };

        # Audio via pipewire.
        hardware.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };

        # OpenSSH daemon.
        services.openssh.enable = true;

        # Firewall.
        networking.firewall.allowedTCPPorts = [
          22 # ssh
          6443 # k3s API server
        ];

        system.stateVersion = "24.05";

        # Home Manager.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.joel = {
          imports = [ homeManager.joel ];
        };
      }
    ];
  };
}
