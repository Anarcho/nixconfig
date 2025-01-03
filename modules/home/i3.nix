{
  config,
  lib,
  pkgs,
  ...
}: let
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
        terminal = "${pkgs.ghostty}/bin/ghostty";

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
            {
              command = "fullscreen enable";
              criteria = {class = "^Alacritty$";};
            }
          ];
        };
        startup = [
          {
            command = "${pkgs.feh}/bin/feh --bg-fill ~/.config/feh/wallpaper.jpg";
            always = true;
          }
          {
            command = "workspace number 1";
            always = false;
          }
        ];
        gaps = {
          inner = 10;
          outer = 5;
          smartGaps = true;
        };

        keybindings = let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in
          lib.mkOptionDefault {
            "${modifier}+Return" = "exec ${pkgs.ghostty}/bin/ghostty";

            "${modifier}+Mod1+1" = "workspace number 1";
            "${modifier}+Mod1+2" = "workspace number 2";
            "${modifier}+Mod1+3" = "workspace number 3";

            # Movement
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+h" = "focus left";
            "${modifier}+l" = "focus left";

            "${modifier}+b" = "exec ${pkgs.firefox}/bin/firefox";
            "${modifier}+o" = "mode obsidian";
          };

        modes = {
          obsidian = {
            "p" = ''exec "xdg-open 'obsidian://open?vault=personal'"; mode "default"'';
            "w" = ''exec "xdg-open 'obsidian://open?vault=work'"; mode "default"'';
            "Escape" = "mode default";
            "Return" = "mode default";
          };
        };

        defaultWorkspace = "workspace number 1";

        workspaceOutputAssign = [
          {
            workspace = "1:Terminal";
            output = "primary";
          }
          {
            workspace = "2:Web";
            output = "primary";
          }
        ];

        assigns = {
          "1:Terminal" = [{class = "^Firefox$";}];
          "2:Web" = [{class = "^code$";}];
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
      i3status
      picom
      ghostty
      firefox
      feh
    ];
  };
}
