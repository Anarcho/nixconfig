{
  plugins.snacks = {
    settings = {
      dashboard = {
        enable = true;
        preset = {
          keys = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = "<leader>ff";
            }
            {
              icon = " ";
              key = "n";
              desc = "New File";
              action = ":ene | startinsert";
            }
            {
              icon = " ";
              key = "/";
              desc = "Find Text";
              action = "<leader>fr";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = "<leader>fg";
            }
            {
              icon = "";
              key = "o";
              desc = "LazyGit";
              action = "<leader>gg";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
          sections = [
            {
              icon = " ";
              pane = 2;
              title = "Keymaps";
              section = "keys";
              padding = 1;
              indent = 3;
            }
            {
              icon = " ";
              pane = 2;
              title = "Recent Files";
              section = "recent_files";
              padding = 1;
              indent = 3;
            }
            {
              icon = " ";
              pane = 2;
              title = "Projects";
              section = "projects";
              padding = 1;
              indent = 3;
            }
          ];
        };
      };
    };
  };
}
