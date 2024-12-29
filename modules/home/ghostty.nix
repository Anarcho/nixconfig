{
  flake,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home.ghostty;
in {
  options.home.ghostty = {
    enable = lib.mkEnableOption "ghostty terminal";
  };
  imports = [
    flake.inputs.ghostty-hm.homeModules.default
  ];

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        gtk-titlebar = false;
        font-size = 12;
        theme = "GruvboxDark";
      };
    };
  };
}
