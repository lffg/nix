{pkgs, ...}: {
  home.packages = with pkgs; [
    iosevka-bin
    merriweather
  ];

  fonts.fontconfig.enable = true;
}
