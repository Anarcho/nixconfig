{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>ff" = {
        options.desc = "file finder";
        action = "find_files";
      };
      "<leader>fg" = {
        options.desc = "find via grep";
        action = "live_grep";
      };
    };
    extensions = {
      file-browser.enable = true;
    };
  };
}
