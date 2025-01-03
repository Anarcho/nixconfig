{
  description = "A home-manager template providing useful tools & settings for Nix-based development";
  inputs = {
    # Principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Software inputs
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.flake-parts.follows = "flake-parts";

    tmux-sessionizer.url = "github:jrmoulton/tmux-sessionizer";
    tmux-sessionizer.inputs.nixpkgs.follows = "nixpkgs";
    tmux-sessionizer.inputs.flake-parts.follows = "flake-parts";
  };
  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = [
        # Import your existing flake-parts modules
        ./modules/flake-parts/devshell.nix
        ./modules/flake-parts/neovim.nix
        ./modules/flake-parts/toplevel.nix
        # Import nixos-unified modules
        inputs.nixos-unified.flakeModules.default
        inputs.nixos-unified.flakeModules.autoWire
      ];

      flake = {
        # Your nixos-unified systems configurations
        systems = {
          vm = {
            system = "x86_64-linux";
            nixos = ./configurations/nixos/vm;
          };

          desktop = {
            system = "x86_64-linux";
            nixos = ./configurations/nixos/desktop;
          };

          wsl = {
            system = "x86_64-linux";
            home-manager = {
              config = ./configurations/home/wsl.nix;
              username = "anarcho";
            };
          };

          linux = {
            system = "x86_64-linux";
            home-manager = {
              config = ./configurations/home/linux.nix;
              username = "anarcho";
            };
          };
        };
      };
    };
}
