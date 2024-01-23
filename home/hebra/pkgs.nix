{pkgs, ...}: {
  home.packages = with pkgs; [
    # Command-line tools
    pulseaudio
  ];
}
