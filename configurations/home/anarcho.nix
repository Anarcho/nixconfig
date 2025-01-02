{
  flake,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.homeModules.default
    self.homeModules.i3
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

  home.stateVersion = "22.11";
}
