{
  pkgs,
  lib,
  ...
}: {
  plugins.snacks = {
    settings = {
      dashboard = {
        enable = true;
        preset = {
          headers = ''


            ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
            ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
            ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝


          '';
        };
        sections = [
          # Header section
          {
            section = "header";
            align = "center";
          }

          # Left Pane - General Actions
          {
            pane = 1;
            title = "Actions";
            section = "keys";
            padding = 1;
            indent = 3;
            keys = [
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
                action = ":LazyGit<CR>";
              }
            ];
          }

          # Left Pane - Obsidian Actions
          {
            pane = 1;
            title = "Obsidian";
            section = "keys";
            padding = 1;
            indent = 3;
            keys = [
              # Create general note
              {
                icon = "󰎚 ";
                key = "c";
                desc = "Create Note";
                action = ":ObsidianNew<CR>";
              }
              # Create daily note
              {
                icon = "󰃰 ";
                key = "d";
                desc = "Create Daily";
                action = ":ObsidianToday<CR>";
              }
              # Find note using native ObsidianQuickSwitch
              {
                icon = "󰍉 ";
                key = "s";
                desc = "Find Note";
                action = ":ObsidianQuickSwitch<CR>";
              }
              # Create from template using ObsidianTemplate
              {
                icon = "󰗈 ";
                key = "t";
                desc = "Create From Template";
                action = ":ObsidianTemplate<CR>";
              }
              # Switch Workspace using native command
              {
                icon = " ";
                key = "w";
                desc = "Switch Workspace";
                action = ":ObsidianWorkspace<CR>";
              }
            ];
          }

          # Right Pane - Recent Files
          {
            pane = 2;
            icon = " ";
            title = "Recent Files";
            section = "recent_files";
            padding = 1;
            indent = 3;
            limit = 10;
          }

          # Right Pane - Recent Obsidian Notes
          {
            pane = 2;
            icon = "󰖬 ";
            title = "Recent Obsidian Notes";
            section = "terminal";
            enabled.__raw = ''
              vim.fn.executable('fd') == 1
            '';
            cmd = "__raw = function() local ws = vim.fn.system('cat ~/.local/state/nvim/obsidian-workspace 2>/dev/null || echo personal'):gsub('%s+', '') return string.format('fd -t f -e md . ~/obsidian/%s --max-depth 4 --changed-within 7d | sed \"s|.*/\\(.*\\)\\.md$|\\1|\"', ws) end";
            height = 15;
            padding = 1;
            ttl = 5;
            indent = 3;
          }

          # Footer - Current Workspace Status
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
