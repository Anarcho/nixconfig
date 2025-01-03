{
  plugins.luasnip.enable = true;

  plugins.cmp = {
    enable = true;
    settings = {
      modes = ["i" "s"];
      action = ''
        function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end
      '';
      source = [
        {name = "path";}
        {name = "nvim_lsp";}
        {name = "luasnip";}
        {name = "buffer";}
      ];
      snippet.expand = ''
        function(args)
          require('luasnip').lsp_expand(args.body)
        end
      '';
    };
  };

  plugins.blink-cmp = {
    enable = true;

    settings = {
      keymap.preset = "super-tab";
      completion = {
        keyword = {
          range = "prefix";
          regex = "[-_]\\|\\k";
        };

        trigger = {
          show_on_keyword = true;
          show_on_trigger_character = true;
        };

        list = {
          max_items = 200;
          selection = "auto_insert";
          cycle = {
            from_bottom = true;
            from_top = true;
          };
        };

        accept.auto_brackets = {
          enabled = true;
          semantic_token_resolution.enabled = true;
        };

        documentation = {
          auto_show = true;
          auto_show_delay_ms = 300;
          treesitter_highlighting = true;
        };
      };

      fuzzy = {
        use_typo_resistance = true;
        use_frecency = true;
        use_proximity = true;
      };

      sources = {
        default = ["lsp" "path" "snippets" "buffer"];
        providers = {
          buffer.score_offset = -5;
          lsp = {
            enabled = true;
            timeout_ms = 500;
          };
        };
      };

      signature = {
        enabled = true;
        window = {
          max_height = 10;
          border = "rounded";
        };
      };
    };
  };
}
