{pkgs, ...}: {
  home.packages = with pkgs; [
    iosevka-bin
    merriweather
    twitter-color-emoji
  ];

  fonts.fontconfig.enable = true;
}
