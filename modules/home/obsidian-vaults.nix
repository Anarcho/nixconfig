{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home.obsidian-vaults;

  generateId = str: builtins.substring 0 16 (builtins.hashString "md5" str);

  makeWorkspaceConfig = name: let
    mainId = generateId "${name}-main";
    tabsId = generateId "${name}-tabs";
    emptyId = generateId "${name}-empty";
    leftId = generateId "${name}-left";
    explorerTabsId = generateId "${name}-explorer-tabs";
    explorerFileId = generateId "${name}-file-explorer";
    rightId = generateId "${name}-right";
  in {
    main = {
      id = mainId;
      type = "split";
      children = [
        {
          id = tabsId;
          type = "tabs";
          children = [
            {
              id = emptyId;
              type = "empty";
              state = {};
            }
          ];
        }
      ];
      direction = "vertical";
    };
    left = {
      id = leftId;
      type = "split";
      children = [
        {
          id = explorerTabsId;
          type = "tabs";
          children = [
            {
              id = explorerFileId;
              type = "file-explorer";
              state = {};
            }
          ];
        }
      ];
      direction = "horizontal";
    };
    right = {
      id = rightId;
      type = "split";
      children = [];
      direction = "horizontal";
    };
    active = emptyId;
  };
in {
  options.home.obsidian-vaults = {
    enable = lib.mkEnableOption "obsidian vaults";

    vaultPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/obsidian";
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

  config = lib.mkIf cfg.enable {
    home.file = lib.mkMerge [
      # Personal vault structure
      (lib.mkIf cfg.enablePersonal {
        "${cfg.vaultPath}/personal/.obsidian/app.json".text = builtins.toJSON {
          "attachmentFolderPath" = "attachments";
          "newFileFolderPath" = "";
          "useMarkdownLinks" = true;
          "showFrontmatter" = true;
        };
        "${cfg.vaultPath}/personal/.obsidian/appearance.json".text = builtins.toJSON {
          "baseFontSize" = 16;
          "theme" = "obsidian";
        };
        "${cfg.vaultPath}/personal/.obsidian/workspace.json".text = builtins.toJSON (makeWorkspaceConfig "personal");
        "${cfg.vaultPath}/personal/.obsidian/core-plugins.json".text = builtins.toJSON [
          "file-explorer"
          "global-search"
          "switcher"
          "graph"
          "backlink"
          "page-preview"
          "daily-notes"
          "templates"
        ];
        "${cfg.vaultPath}/personal/daily/.gitkeep".text = "";
        "${cfg.vaultPath}/personal/attachments/.gitkeep".text = "";
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
        "${cfg.vaultPath}/work/.obsidian/app.json".text = builtins.toJSON {
          "attachmentFolderPath" = "attachments";
          "newFileFolderPath" = "";
          "useMarkdownLinks" = true;
          "showFrontmatter" = true;
        };
        "${cfg.vaultPath}/work/.obsidian/appearance.json".text = builtins.toJSON {
          "baseFontSize" = 16;
          "theme" = "obsidian";
        };
        "${cfg.vaultPath}/work/.obsidian/workspace.json".text = builtins.toJSON (makeWorkspaceConfig "work");
        "${cfg.vaultPath}/work/.obsidian/core-plugins.json".text = builtins.toJSON [
          "file-explorer"
          "global-search"
          "switcher"
          "graph"
          "backlink"
          "page-preview"
          "daily-notes"
          "templates"
        ];
        "${cfg.vaultPath}/work/daily/.gitkeep".text = "";
        "${cfg.vaultPath}/work/attachments/.gitkeep".text = "";
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
