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
      type = lib.types.listOf lib.types.str;
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
    services = {
      xserver = {
        enable = true;
        videoDrivers = cfg.videoDrivers;

        # Window Manager configuration
        windowManager.i3 = {
          enable = true;
          package = pkgs.i3-gaps;
        };

        # Display Manager configuration
        displayManager = {
          lightdm = {
            enable = true;
          };
        };
      };
      displayManager.defaultSession = "none+i3";
    };

    environment.systemPackages = with pkgs; [
      xorg.libX11
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXi
    ];
  };
}
