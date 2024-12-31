# Neovim configuration managed using https://github.com/nix-community/nixvim
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];
}
