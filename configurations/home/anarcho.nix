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
  ];
  home.username = "anarcho";
  home.homeDirectory = lib.mkDefault "/${
    if pkgs.stdenv.isDarwin
    then "Users"
    else "home"
  }/anarcho";

  home.i3.enable = true;
  home.tmux.enable = true;

  home.stateVersion = "22.11";
}
