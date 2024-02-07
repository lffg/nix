# This file is used by `hyprland.nix`
{pkgs, ...}: {
  bg-init = pkgs.writeShellApplication {
    name = "bg-init";
    runtimeInputs = [pkgs.swww];
    text = ''
      swww init
    '';
  };

  bg-next = pkgs.writeShellApplication {
    name = "bg-next";
    runtimeInputs = [pkgs.swww];
    text = builtins.readFile ./next.sh;
  };
}
