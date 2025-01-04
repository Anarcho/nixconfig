{
  pkgs,
  lib,
  ...
}: {
  plugins.dashboard = {
    enable = true;
    settings = {
      theme = "doom";
      change_to_vcs_root = true;

      hide = {
        statusline = true;
        tabline = true;
      };

      config = {
        disable_move = true;
        packages.enable = false;
        week_header.enable = false;

        header = [
          "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
          "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ""
        ];

        center = [
          # Find Files Section
          {
            icon = "🔍 ";
            desc = "Find Files";
            key = " ";
            key_format = "";
            action = "";
          }
          {
            icon = "󰈞 ";
            desc = "Find Files";
            key = "f";
            key_format = " %s";
            action = "FzfLua files";
          }
          {
            icon = "󰊄 ";
            desc = "Find Word";
            key = "w";
            key_format = " %s";
            action = "FzfLua live_grep";
          }
          {
            icon = "󰥨 ";
            desc = "File Browser";
            key = "e";
            key_format = " %s";
            action = "FzfLua file_browser";
          }
          {
            icon = "󰋚 ";
            desc = "Recent Files";
            key = "r";
            key_format = " %s";
            action = "FzfLua oldfiles";
          }

          # Obsidian Section
          {
            icon = "📝 ";
            desc = "Obsidian";
            key = " ";
            key_format = "";
            action = "";
          }
          {
            icon = "󰠮 ";
            desc = "New Note";
            key = "n";
            key_format = " %s";
            action = "ObsidianNew";
          }
          {
            icon = "󰃭 ";
            desc = "Daily Note";
            key = "d";
            key_format = " %s";
            action = "ObsidianToday";
          }
          {
            icon = "󰈙 ";
            desc = "From Template";
            key = "t";
            key_format = " %s";
            action = "ObsidianTemplate";
          }
          {
            icon = "󱋢 ";
            desc = "Switch Workspace";
            key = "w";
            key_format = " %s";
            action.__raw = ''
              function()
                local workspaces = { "personal", "work" }
                require('fzf-lua').fzf_exec(
                  workspaces,
                  {
                    prompt = "Select Workspace> ",
                    actions = {
                      ['default'] = function(selected)
                        if selected and selected[1] then
                          local workspace = selected[1]
                          vim.fn.system(string.format("echo '%s' > ~/.local/state/nvim/obsidian-workspace", workspace))
                          vim.notify("Switched to workspace: " .. workspace)
                        end
                      end
                    }
                  }
                )
              end
            '';
          }

          # Tmux Section
          {
            icon = "󰆍 ";
            desc = "Tmux";
            key = " ";
            key_format = "";
            action = "";
          }
          {
            icon = "󰆍 ";
            desc = "Switch Session";
            key = "s";
            key_format = " %s";
            action = "!tms switch";
          }
          {
            icon = "󰐕 ";
            desc = "New Session";
            key = "S";
            key_format = " %s";
            action = "!tms open-session";
          }

          # Quit Option
          {
            icon = "󰗼 ";
            desc = "Quit Neovim";
            key = "q";
            key_format = " %s";
            action = "qa";
          }
        ];

        # Status in footer with gruvbox colors
        footer = {
          __raw = ''
            function()
              local workspace = vim.fn.system("cat ~/.local/state/nvim/obsidian-workspace 2>/dev/null || echo personal"):gsub("^%s*(.-)%s*$", "%1")
              local tmux_session = vim.fn.system("tmux display-message -p '#S' 2>/dev/null || echo 'No session'"):gsub("^%s*(.-)%s*$", "%1")
              
              return {
                "",
                "",
                "",
                "═══════════════════════ System Status ═══════════════════════",
                string.format("󱝂  Workspace: %s        󰆍  Tmux: %s", workspace, tmux_session),
                "═══════════════════════════════════════════════════════════"
              }
            end
          '';
        };
      };
    };
  };

  extraConfigLua = ''
    -- Set up highlight groups for dashboard with gruvbox colors
    vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = "#fb4934" })  -- bright red
    vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = "#b8bb26" })  -- bright green
    vim.api.nvim_set_hl(0, 'DashboardShortcut', { fg = "#83a598" })  -- bright blue
    vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = "#d3869b" })  -- bright purple
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>n";
      action = ":ObsidianNew<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>d";
      action = ":ObsidianToday<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>t";
      action = ":ObsidianTemplate<CR>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>w";
      action.__raw = ''
        function()
          local workspaces = { "personal", "work" }
          require('fzf-lua').fzf_exec(
            workspaces,
            {
              prompt = "Select Workspace> ",
              actions = {
                ['default'] = function(selected)
                  if selected and selected[1] then
                    local workspace = selected[1]
                    vim.fn.system(string.format("echo '%s' > ~/.local/state/nvim/obsidian-workspace", workspace))
                    vim.notify("Switched to workspace: " .. workspace)
                  end
                end
              }
            }
          )
        end
      '';
      options.silent = true;
    }
  ];
}