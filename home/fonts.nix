{pkgs, ...}: {
  home.packages = with pkgs; [
    iosevka-bin
  ];

  fonts.fontconfig.enable = true;
}
