{
  flake,
  pkgs,
  ...
}: {
  imports = [
    flake.inputs.ghostty-hm.homeModules.default
  ];

  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {
      gtk-titlebar = false;
      font-size = 12;
      theme = "GruvboxDark";
    };
  };
}
