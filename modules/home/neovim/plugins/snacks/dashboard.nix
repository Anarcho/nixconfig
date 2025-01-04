{
  pkgs,
  lib,
  ...
}: {
  plugins.snacks = {
    enable = true;
    settings = {
      dashboard = {
        enable = true;
        # Define our layout options
        width = 60;
        pane_gap = 4;

        preset = {
          header = ''
            ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
            ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
            ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
          '';

          # Define default keymaps for the actions section
          actions = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = "<leader>ff";
            }
            {
              icon = " ";
              key = "/";
              desc = "Find Text";
              action = "<leader>fr";
            }
            {
              icon = " ";
              key = "n";
              desc = "New File";
              action = ":ene | startinsert";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = "<leader>fo";
            }
            {
              icon = "";
              key = "g";
              desc = "LazyGit";
              action = ":LazyGit";
            }
          ];

          # Define obsidian keymaps
          obsidian = [
            {
              icon = "󰎚 ";
              key = "c";
              desc = "Create Note";
              action = ":ObsidianNew";
            }
            {
              icon = "󰃰 ";
              key = "d";
              desc = "Create Daily";
              action = ":ObsidianToday";
            }
            {
              icon = "󰍉 ";
              key = "s";
              desc = "Find Note";
              action = ":ObsidianQuickSwitch";
            }
            {
              icon = "󰗈 ";
              key = "t";
              desc = "Create From Template";
              action = ":ObsidianTemplate";
            }
            {
              icon = " ";
              key = "w";
              desc = "Switch Workspace";
              action = ":ObsidianWorkspace";
            }
          ];
        };

        sections = [
          # Header Section
          {
            section = "header";
          }

          # Left Pane - Actions Section
          {
            pane = 1;
            title = "Actions";
            section = "keys";
            keys = "actions";
            padding = 1;
            indent = 3;
          }

          # Left Pane - Obsidian Section
          {
            pane = 1;
            title = "Obsidian";
            section = "obsidian";
            keys = "obsidian";
            padding = 1;
            indent = 3;
          }

          # Right Pane - Recent Files
          {
            section = "recent_files";
            title = "Recent Files";
            icon = " ";
            pane = 2;
            padding = 1;
            indent = 3;
            limit = 10;
          }

          # Right Pane - Recent Obsidian Notes
          {
            section = "terminal";
            title = "Recent Obsidian Notes";
            icon = "󰖬 ";
            pane = 2;
            cmd = "cat ~/.local/state/nvim/obsidian-workspace 2>/dev/null || echo personal | xargs -I {} fd -t f -e md . ~/obsidian/{} --max-depth 4 --changed-within 7d | sed 's|.*/\\(.*\\)\\.md$|\\1|'";
            height = 15;
            padding = 1;
            indent = 3;
            ttl = 5;
          }

          # Footer - Current Workspace
          {
            section = "terminal";
            cmd = "echo -n 'Current Workspace: ' && (cat ~/.local/state/nvim/obsidian-workspace 2>/dev/null || echo personal)";
            height = 1;
            padding = 1;
            ttl = 5;
            align = "center";
          }
        ];
      };
    };
  };
}
