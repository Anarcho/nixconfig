{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.nixosModules.default
    self.nixosModules.system
    self.nixosModules.disko
    ./configuration.nix
  ];

  networking.hostName = "xdevx";
  nixpkgs.config.allowUnfree = true;

  home-manager.users."anarcho" = {
    imports = [(self + /configurations/home/anarcho.nix)];
  };
}
