{
  lib,
  config,
  ...
}: {
  options.host = {
    type = lib.mkOption {
      type = lib.types.enum ["nixos" "wsl" "linux"];
      description = "System host";
    };

    isNixOS = lib.mkOption {
      type = lib.types.bool;
      default = config.host.type == "nixos";
      readOnly = true;
    };

    isWSL = lib.mkOption {
      type = lib.types.bool;
      default = config.host.type == "wsl";
      readOnly = true;
    };
  };
}
