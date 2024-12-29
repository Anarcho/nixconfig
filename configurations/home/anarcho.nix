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
  ];
  home.username = "anarcho";
  home.homeDirectory = lib.mkDefault "/${
    if pkgs.stdenv.isDarwin
    then "Users"
    else "home"
  }/anarcho";
  home.stateVersion = "22.11";
}
