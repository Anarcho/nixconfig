{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.i3;
in {
  options.modules.i3 = {
    enable = lib.mkEnableOption "i3 window manager";

    isVirtualMachine = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the system is running in a virtual machine";
    };

    videoDrivers = lib.mkOption {
      type = lib.types.listOf lib.types.string;
      default = ["modesetting"];
      description = ''
        List of video drivers to use. Possible values are:
        - intel
        - nvidia
        - nouveau
        - radeon
        - amdgpu
        - vmware
        - virtualbox
        - modesetting
        - fbdev
        - vesa
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;

      videoDrivers = cfg.videoDrivers;

      displayManager = {
        lightdm = {
          enable = true;
        };
        defaultSession = "none+i3";
      };

      windowManager.i3 = {
        virtualisation.virtualbox.guest = lib.mkIf cfg.isVirtualMachine {
          enable = true;
          x11 = true;
        };
      };
    };
  };
}
