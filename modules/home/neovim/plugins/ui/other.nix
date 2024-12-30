{
  plugins = {
    web-devicons.enable = true;

    noice = {
      enable = true;
      settings.presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
      };
    };

    which-key = {
      enable = true;
      settings = {
        presets = "helix";
      };
    };
  };
}
