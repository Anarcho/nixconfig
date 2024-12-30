{
  plugins.treesitter = {
    enable = true;
    settings = {
      ensureInstalled = [
        "bash"
        "c"
        "cpp"
        "lua"
        "python"
        "nix"
        "nix"
        "rust"
        "zig"
        "markdown"
        "markdown_inline"
      ];
      incremntal_selection = {
        enable = true;
        keymaps = {
          init_selection = false;
          node_incremental = "grn";
          scope_incremental = "grc";
          node_decremental = "grm";
        };
      };
      indent = {
        enable = true;
      };
      sync_install = false;
      auto_install = true;
    };
  };
}
