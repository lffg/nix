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

  wayland.windowManager.hyprland.settings = {
    exec-once = ["wp init"];
    exec = ["wp next"];
  };
}
