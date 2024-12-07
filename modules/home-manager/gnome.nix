{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.gnome;
in {

  options.modules.gnome = {
    enable = mkEnableOption "gnome";
  };

  config = mkIf cfg.enable {

    programs.gnome-shell = {
      enable = true;
      extensions = [
        { package = pkgs.gnomeExtensions.vitals; }
      ];
    };

    home.file.".config/monitors.xml".text = ''
      <monitors version="2">
        <configuration>
          <layoutmode>logical</layoutmode>
          <logicalmonitor>
            <x>1920</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>HDMI-1</connector>
                <vendor>ACR</vendor>
                <product>ED320QR S</product>
                <serial>22190144C3W01</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>DP-3</connector>
                <vendor>GSM</vendor>
                <product>LG FHD</product>
                <serial>310TFVB1A183</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>1920</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>HDMI-1</connector>
                <vendor>ACR</vendor>
                <product>ED320QR S</product>
                <serial>22190144C3W01</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>DP-3</connector>
                <vendor>GSM</vendor>
                <product>LG FHD</product>
                <serial>310TFVB1A183</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
      </monitors>
    '';

  };

}
