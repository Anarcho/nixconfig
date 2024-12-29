{
  config,
  lib,
  pkgs,
  flake,
  ...
}: let
  cfg = config.home.tmux;
  inherit (flake) inputs;
in {
  options.home.tmux = {
    enable = lib.mkEnableOption "tmux window manager";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      terminal = "screen-256color";
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 50000;
      keyMode = "vi";
      mouse = true;
      prefix = "C-a";

      plugins = with pkgs; [
        tmuxPlugins.cpu
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-internal '60'
          '';
        }
        tmuxPlugins.sensible
        tmuxPlugins.gruvbox
        tmuxPlugins.tmux-powerline
      ];

      extraConfig = ''
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        bind -r ^ last-window
        bind -r k select-pane -U
        bind -r j select-pan -D
        bind -r h select-pane -L
        bind -r l select-pane -R

        # Tmux-Sessionizer
        bind C-f display-popup -E "tms"
        bind C-s display-popup -E "tms switch"

        bind C-w display-popup -E "tms windows"
        set -g status-right "#(tms sessions)"
        bind -r '(' switch-client -p\; refresh-client -S
        bind -r ')' switch-client -n\; refresh-client -S
        bind C-r command-prompt "Rename active session to: " "run-shell 'tms rename %1'"
      '';
    };

    home.packages = with pkgs; [
      inputs.tmux-sessionizer.packages.${pkgs.system}.default
      fzf
    ];
  };
}
