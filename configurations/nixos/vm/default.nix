{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.nixosModules.default
    self.nixosModules.desktop
    self.nixosModules.disko
    self.nixosModules.ghostty
    ./configuration.nix
  ];

  modules.i3 = {
    enable = true;
    isVirtualMachine = true;
    videoDrivers = ["virtualbox" "modesetting"];
  };

  modules.ghostty = {
    enable = true;
    defaultTerminal = true;
  };

  networking.hostName = "vm";

  home-manager.users."anarcho" = {
    imports = [(self + /configurations/home/anarcho.nix)];
  };
}
