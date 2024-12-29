{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
in {
  imports = [
    inputs.nix-index-deatabase.hmModule.nix-index
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    sd
    wget
    nixpkgs-fmt
  ];

  home.shellAliases = {};

  programs = {
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    nix-index-database.comma.enable = true;

    bat.enable = true;
    fzf.enable = true;
    jq.enable = true;
    btop.enable = true;
  };
}
