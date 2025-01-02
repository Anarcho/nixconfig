{
  plugins.fzf-lua = {
    enable = true;
    settings = {
      # General settings
      global_resume = true;
      global_resume_query = true;
      winopts = {
        height = 0.85;
        width = 0.80;
        preview = {
          layout = "vertical";
          vertical = "down:45%";
        };
      };

      # Customizing fzf-lua behavior
      files = {
        prompt = "Files❯ ";
        cmd = "fd --type f --hidden --follow --exclude .git";
      };

      grep = {
        prompt = "Rg❯ ";
        input_prompt = "Grep For❯ ";
      };

      oldfiles = {
        prompt = "History❯ ";
      };
    };

    # Optional: Define keymaps here
    keymaps = {
      "<leader>ff" = "files";
      "<leader>fg" = "live_grep";
      "<leader>fb" = "buffers";
      "<leader>fh" = "oldfiles";
      "<leader>fk" = "keymaps";
    };
  };
}
