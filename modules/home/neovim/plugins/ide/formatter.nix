{
  plugins.conform-nvim = {
    enable = true;
    formatters_by_ft = {
      # Shell scripts
      bash = [
        "shellcheck"
        "shellharden"
        "shfmt"
      ];
      sh = [
        "shellcheck"
        "shellharden"
        "shfmt"
      ];

      # C/C++
      c = ["clang_format"];
      cpp = ["clang_format"];
      objc = ["clang_format"];
      objcpp = ["clang_format"];

      # Lua
      lua = ["stylua"];

      # Python
      python = ["black"];

      # Zig
      zig = ["zigfmt"];

      # Rust
      rust = ["rustfmt"];

      # Go
      go = ["gofmt" "goimports"];

      # Nix
      nix = ["alejandra"];
    };
    format_on_save = ''
      function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        local function on_format(err)
          if err and err:match("timeout$") then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end
        return { timeout_ms = 200, lsp_fallback = true }, on_format
       end
    '';
    # Keeps your existing format_after_save logic
    format_after_save = ''
      function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { lsp_fallback = true }
      end
    '';
  };
}
