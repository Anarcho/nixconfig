{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home.obsidian_vaults;
in {
  options.home.obsidian_vaults = {
    vaultPath = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/obsidian";
      description = "Base path for Obsidian vaults";
    };

    enablePersonal = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable personal vault";
    };

    enableWork = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable work vault";
    };
  };

  config = lib.mkIf config.modules.obsidiab.enable {
    home.file = lib.mkMerge [
      # Personal vault structure
      (lib.mkIf cfg.enablePersonal {
        "${cfg.vaultPath}/personal/.obsidian/.gitkeep".text = "";
        "${cfg.vaultPath}/personal/daily/.gitkeep".text = "";
        "${cfg.vaultPath}/personal/templates/daily.md".text = ''
          # Daily Note - {{date}}

          ## Tasks
          - [ ]

          ## Notes

        '';
        "${cfg.vaultPath}/personal/templates/default.md".text = ''
          # {{title}}

          Created: {{date}}

          ## Notes

        '';
      })

      # Work vault structure
      (lib.mkIf cfg.enableWork {
        "${cfg.vaultPath}/work/.obsidian/.gitkeep".text = "";
        "${cfg.vaultPath}/work/daily/.gitkeep".text = "";
        "${cfg.vaultPath}/work/templates/daily.md".text = ''
          # Work Log - {{date}}

          ## Tasks
          - [ ]

          ## Meetings

          ## Notes

        '';
        "${cfg.vaultPath}/work/templates/default.md".text = ''
          # {{title}}

          Created: {{date}}
          Project:

          ## Notes

        '';
      })
    ];
  };
}
