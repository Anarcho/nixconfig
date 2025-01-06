{
  plugins.obsidian = {
    enable = true;
    settings = {
      workspaces = [
        {
          name = "personal";
          path = "~/obsidian/personal";
        }
        {
          name = "work";
          path = "~/obsidian/work";
        }
      ];

      workspace_state_file = "~/.local/state/nvim/obsidian-workspace";

      daily_notes = {
        folder = "daily";
        date_format = "%Y-%m-%d";
        template = "templates/daily.md";
      };

      templates = {
        subdir = "templates";
        date_format = "%Y-%m-%d";
        time_format = "%H:%M";
      };

      completion = {
        nvim_cmp = true;
        min_chars = 2;
      };

      picker = {
        name = "fzf-lua";
      };

      ui = {
        enable = true;
      };
    };
  };

  extraConfigLua = ''
    -- Add a function to switch workspaces
    function SwitchObsidianVault(selected_vault)
      if selected_vault then
        -- Save the workspace selection to state file
        vim.fn.system(string.format("echo '%s' > ~/.local/state/nvim/obsidian-workspace", selected_vault))

        -- Get the obsidian client
        local obsidian = require("obsidian")
        local client = obsidian.get_client()

        if client then
          -- Find the workspace config by name
          for _, workspace in ipairs(client.workspaces) do
            if workspace.name == selected_vault then
              -- Switch to the workspace using the client's method
              client:switch_workspace(workspace)
              vim.notify("Switched to workspace: " .. selected_vault)
              return
            end
          end
        end
      end
    end
  '';
}
