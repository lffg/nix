{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: let
  inherit (pkgs.lib.strings) concatStringsSep;
in {
  home.packages = with pkgs; [
    # Command-line tools
    wl-clipboard
    pulseaudio
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    # Make openssl visible throughout the system
    openssl
    pkg-config

    # GUI applications
    okular
    # We install these via Homebrew on Darwin
    pkgs-unstable.logseq
    brave
    spotify
  ];

  home.sessionVariables = {
    PKG_CONFIG_PATH = concatStringsSep ":" (with pkgs; [
      "${openssl.dev}/lib/pkgconfig"
    ]);
  };
}
