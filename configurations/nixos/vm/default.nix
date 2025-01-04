{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.nixosModules.default
    self.nixosModules.system
    self.nixosModules.disko
    ./configuration.nix
  ];

  modules.i3 = {
    enable = true;
    isVirtualMachine = true;
    videoDrivers = ["virtualbox" "modesetting"];
  };

  modules.obsidian = {
    enable = true;
  };

  networking.hostName = "vm";

  nixpkgs.config.allowUnfree = true;

  home-manager.users."anarcho" = {
    imports = [(self + /configurations/home/anarcho.nix)];
  };
}
