{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in
  self: super: {
    ghostty = inputs.ghostty.packages.${self.system}.default;
  }
