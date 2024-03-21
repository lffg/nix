{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkOption;

  volume = pkgs.writeShellApplication {
    name = "volume";
    runtimeInputs = [
      pkgs.pulseaudio
      pkgs.libnotify
    ];
    text = builtins.readFile ./volume.sh;
  };
in {
  options.lffg.volume = {
    package = mkOption {
      type = types.package;
      default = volume;
    };
  };

  config = {
    home.packages = [
      volume
    ];

    services.wob = {
      enable = true;
      # Socket is created in `$XDG_RUNTIME_DIR`
      systemd = true;
    };
  };
}
