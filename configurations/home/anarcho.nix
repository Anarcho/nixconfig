{
  flake,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.homeModules.default
    self.homeModules.i3
    self.homeModules.obsidian-vaults
    self.homeModules.packages
  ];
  home.username = "anarcho";
  home.homeDirectory = lib.mkDefault "/${
    if pkgs.stdenv.isDarwin
    then "Users"
    else "home"
  }/anarcho";

  home.file = {
    ".config/nvim/assets/dashboard.png".source = ../../assets/nix-dashboard.png;
  };
  home.file = {
    ".config/feh/wallpaper.jpg".source = ../../assets/wallpaper.jpg;
  };

  home.i3.enable = true;
  home.tmux.enable = true;

  home.obsidian-vaults = {
    enable = true;
    vaultPath = "${config.home.homeDirectory}/obsidian";
    enablePersonal = true;
    enableWork = true;
  };

  home.stateVersion = "22.11";
}
