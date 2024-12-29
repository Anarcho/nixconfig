{
  flake,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  nix.settings.trusted-users = ["root" "aaronk"];

  services.openssh.enable = true;
}
