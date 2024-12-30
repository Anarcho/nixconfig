{
  flake,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
  cfg = config.home.ghostty;
in {
  options.home.ghostty = {
    enable = lib.mkEnableOption "ghostty terminal";
  };
  imports = [
    flake.inputs.ghostty-hm.homeModules.default
  ];

  config = lib.mkIf cfg.enable {
    home.packages = [
      self.ghostty.${pkgs.system}.default
    ];
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
