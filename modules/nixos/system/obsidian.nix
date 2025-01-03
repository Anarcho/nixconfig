{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.obsidian;
in {
  options.modules.obsidian = {
    enable = lib.mkEnableOption "obsidian";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
