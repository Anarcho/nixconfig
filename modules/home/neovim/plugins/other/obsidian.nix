{
  plugins.obsidian = {
    enable = false;
    settings = {
      workspaces = [
        {
          name = "work";
          path = "~/obsidian/work";
        }
        {
          name = "personal";
          path = "~/obsidian/personal";
        }
      ];

      new_notes_location = "current_dir";

      preferred_link_style = "wiki";

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
        note_mappings = {
          new = "<C-x>";
          insert_link = "<C-l>";
        };
        tag_mappings = {
          tag_note = "<C-x>";
          insert_tag = "<C-l>";
        };
      };
      ui = {
        enable = true;
        checkboxes = {
          " " = {
            char = "☐";
            hl_group = "ObsidianTodo";
          };
          "x" = {
            char = "☒";
            hl_group = "ObsidianDone";
          };
          ">" = {
            char = "";
            hl_group = "ObsidianRightArrow";
          };
        };
        bullets = {
          char = "•";
          hl_group = "ObsidianBullet";
        };
      };
    };
  };
}
