{pkgs, ...}:
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
    keymaps.lspBuf = {
      "gd" = "definition";
      "gD" = "references";
      "gt" = "type_definition";
      "gi" = "implementation";
      "K" = "hover";
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    plenary-nvim
  ];

  plugins.none-ls = {
    enable = true;
    sources = {
      formatting = {
        black.enable = true;
        nixpkgs_fmt.enable = true;
        prettier.enable = true;
        clang_format.enable = true;
        alejandra.enable = true;
      };
    };
  };

  plugins.trouble = {
    enable = true;
  };
}
