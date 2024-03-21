{pkgs, ...}: let
  swww = pkgs.swww;

  wp = pkgs.writeShellApplication {
    name = "wp";
    runtimeInputs = [swww];
    text = builtins.readFile ./wp.sh;
  };
in {
  home.packages = [
    wp
    swww
  ];

  # These are order sensitive, so we use `extraConfig`
  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = wp init
    exec = wp next
  '';
}
