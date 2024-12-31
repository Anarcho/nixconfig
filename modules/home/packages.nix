{pkgs, ...}: {
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Unix tools
    ripgrep # Better `grep`
    fd
    sd
    tree
    gnumake

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt

    # Dev
    tmate

    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less
  ];

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs = {
    bat.enable = true;
    fzf.enable = true;
    jq.enable = true;
    btop.enable = true;
  };
}
