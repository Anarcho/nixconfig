{
  plugins.lsp = {
    enable = true;
    servers = {
      pyright.enable = true;
      zls.enable = true;
      clangd.enable = true;
      nil_ls.enable = true;
      bashls.enable = true;
    };
  };

  plugins.none-ls = {
    enable = true;
    sources = {
      formatting = {
        black.enable = true;
        nixpkgs_fmt.enable = true;
        prettier.enable = true;
        clang_format.enable = true;
      };
    };
  };

  plugins.trouble = {
    enable = true;
  };
}
