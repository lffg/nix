{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Command-line tools
    pulseaudio
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];
}
