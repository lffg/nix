{
  pkgs,
  lib,
  vars,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
  inherit (lib) mkIf;
in {
  # GPG
  programs.gpg.enable = true;

  services.gpg-agent = mkIf isLinux {
    enable = true;
    pinentryFlavor = "curses";
  };
  home.packages = mkIf isLinux [
    pkgs.pinentry-curses
  ];

  # Git signing
  programs.git = let
    keys = {
      "hebra" = "E1FEC20C853E9736";
      "akkala" = "1AAB523B01D50CE9";
      "lanayru" = "76C182B31CED00EA";
    };
  in {
    signing = {
      signByDefault = true;
      key = keys."${vars.host.name}";
    };
    extraConfig = {
      commit.gpgsign = true;
      gpg.program = "${pkgs.gnupg}/bin/gpg2";
      credential.helper = mkIf isDarwin "osxkeychain";
    };
  };
}
