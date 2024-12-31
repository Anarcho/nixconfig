{
  pkgs,
  lib,
  ...
}: {
  plugins.conform-nvim = {
    enable = true;
    autoLoad = true;
    settings = {
      formatters_by_ft = {
        bash = ["shellcheck" "shellharden" "shfmt"];
        sh = ["shellcheck" "shellharden" "shfmt"];
        c = ["clang_format"];
        cpp = ["clang_format"];
        objc = ["clang_format"];
        objcpp = ["clang_format"];
        lua = ["stylua"];
        python = ["black" "isort"];
        zig = ["zigfmt"];
        rust = ["rustfmt"];
        go = ["gofmt" "goimports" "gofumpt"];
        nix = ["alejandra"];
      };
      format_on_save = ''
        {timeout_ms = 200, lsp_fallback = true}
      '';
    };
  };
}
