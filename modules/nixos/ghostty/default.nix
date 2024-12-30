{
  config,
  flake,
  lib,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (lib) mkIf mkOption mkEnableOption types;
  cfg = config.modules.ghostty;
in {
  imports = [
    inputs.ghostty.nixosModules.ghostty
  ];
  options.modules.ghostty = {
    enable = mkEnableOption "ghostty terminal";
    defaultTerminal = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to set ghostty as the default terminal";
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = [
        flake.inputs.ghostty.packages.${pkgs.system}.default
      ];

      sessionVariables = mkIf cfg.defaultTerminal {
        XDG_TERMINAL = flake.inputs.ghostty.packages.${pkgs.system}.default;
      };
    };
  };
}
