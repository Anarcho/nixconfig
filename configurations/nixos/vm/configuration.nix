{
  imports = [
    ./hardware-configuration.nix
  ];

  time.timeZone = "Australia/Brisbane";

  nixpkgs.hostPlatform = "x86_64-linux";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.anarcho = {
    isNormalUser = true;
    initialPassword = "pass";
    extraGroups = ["wheel" "networkmanager"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuUz6JTu3ZB93YDEtck7IxaZ6lKpAslwMls9IpTbpMN anarcho@nix"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKq7kAc2P4mDl78iRDl/XItrac0BATHNNWWAFYuavlow anarcho@nixvm"
    ];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.virtualbox.guest.enable = true;

  security = {
    sudo.wheelNeedsPassword = false;
  };

  system.stateVersion = "24.05";
}
