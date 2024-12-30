{
  flake,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
  cfg = config.home.i3;
in {
  options.home.i3 = {
    enable = lib.mkEnableOption "i3 window manager";
  };

  config = lib.mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";
        terminal = "${flake.inputs.ghostty.packages.${pkgs.system}.default}/bin/ghostty";
        focus = {
          followMouse = true;
        };

        window = {
          border = 1;
          titlebar = false;

          commands = [
            {
              command = "border pixel 2";
              criteria = {class = "^.*";};
            }
          ];
        };

        gaps = {
          inner = 5;
          outer = 2;
          smartGaps = true;
        };

        keybindings = let
          modifier = config.xsession.windowManager.i3.config.modifier;
          terminal = config.xsession.windowManager.i3.config.terminal;
        in
          lib.mkOptionDefault {
            "${modifier}+Return" = "exec ${flake.inputs.ghostty.packages.${pkgs.system}.default}/bin/ghostty";
          };

        assigns = {
          "1" = [{class = "^Firefox$";}];
          "2" = [{class = "^code$";}];
        };

        bars = [
          {
            position = "top";
            statusCommand = "${pkgs.i3status}/bin/i3status";
            colors = {
              background = "#282828";
              statusline = "#ebdbb2";
              separator = "#666666";
              focusedWorkspace = {
                border = "#458588";
                background = "#458588";
                text = "#ebdbb2";
              };
              activeWorkspace = {
                border = "#1d2021";
                background = "#1d2021";
                text = "#ebdbb2";
              };
              inactiveWorkspace = {
                border = "#1d2021";
                background = "#1d2021";
                text = "#ebdbb2";
              };
              urgentWorkspace = {
                border = "#cc241d";
                background = "#cc241d";
                text = "#ebdbb2";
              };
            };
          }
        ];
      };
    };

    home.packages = with pkgs; [
      ghostty
      i3status
      picom
      flake.inputs.ghostty.packages.${pkgs.system}.default
    ];
  };
}
