{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
in {
  home.packages = with pkgs; [
    ripgrep
    fd
    sd
    wget
    nixpkgs-fmt
  ];

  home.shellAliases = {};

  programs = {
    bat.enable = true;
    fzf.enable = true;
    jq.enable = true;
    btop.enable = true;
  };
}
