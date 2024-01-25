{pkgs, ...}: {
  home.packages = with pkgs; [
    iosevka-bin
    twitter-color-emoji
  ];

  fonts.fontconfig.enable = true;
}
