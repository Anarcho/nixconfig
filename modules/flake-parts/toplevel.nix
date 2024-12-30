{inputs, ...}: {
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];
  perSystem = {
    self',
    pkgs,
    ...
  }: {
    formatter = pkgs.nixpkgs-fmt;

    # Enables 'nix run' to activate.
    packages.default = self'.packages.activate;

    nixos-unified = {
      primary-inputs = [
        "nixpkgs"
        "home-manager"
        "nixos-unified"
        "nix-index-database"
        "nixvim"
      ];

      modules = {
        nixos.ghostty = ./modules/nixos/ghostty;
      };
    };
  };
}
