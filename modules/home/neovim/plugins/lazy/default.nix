{pkgs, ...}:
{
  plugins.lazy = {
    enable = true;
    plugins = [
      {
        pkg = pkgs.vimPlugins.snacks-nvim;
        opts = {
          dashbboard = { enabled = true;};
        };
      }
    ];
  };
}
