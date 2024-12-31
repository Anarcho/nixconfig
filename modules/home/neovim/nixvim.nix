{pkgs, ...}:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  home.packages = with pkgs; [
    shellcheck
    shellharden
    shfmt
    clang-tools
    stylua
    black
    zig
    rustfmt
    go
    gopls
    alejandra
  ];
}
