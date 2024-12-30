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
}
