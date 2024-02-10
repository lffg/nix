{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        emoji = ["Twitter Color Emoji"];
        monospace = ["Iosevka Fixed"];
        sansSerif = ["Noto Sans"];
        serif = ["Noto Serif"];
      };
    };

    packages = with pkgs; [
      iosevka-bin
      twitter-color-emoji
      noto-fonts
    ];
  };
}
