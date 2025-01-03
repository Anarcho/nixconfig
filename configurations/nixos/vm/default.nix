{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.nixosModules.default
    self.nixosModules.desktop
    self.nixosModules.disko
    ./configuration.nix
  ];

  host.type = "nixos";

  modules.i3 = {
    enable = true;
    isVirtualMachine = true;
    videoDrivers = ["virtualbox" "modesetting"];
  };

  networking.hostName = "vm";

  home-manager.users."anarcho" = {
    imports = [(self + /configurations/home/anarcho.nix)];
    host.type = "nixos";
  };
}
