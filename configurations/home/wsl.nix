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
    self.homeModules.packages
  ];

  host.type = "wsl";

  home = {
    username = "aaronk";
    homeDirectory = "/home/aaronk";
  };

  modules = {
    i3.enable = false;
    shell.enable = true;
    terminal.enable = false;
    development.enable = true;
  };

  home.stateVersion = "22.11";
}
