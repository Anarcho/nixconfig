{
  flake,
  lib,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    inputs.alejandra.nixosModules.alejandra
  ];
  environment.systemPackages = [inputs.alejandra.defaultPackage.${pkgs.system}.default];
}
