{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.home) homeDirectory;
in {
  programs.fish = {
    enable = true;

    shellAliases = {
      # General commands:
      g = "git";
      cls = "clear";
      # del = "trash";
      psqll = "PAGER='less -S' psql";

      p = "pnpm";

      # Typos:
      "cd.." = "cd ..";
      "code." = "code .";

      # Navigation
      cdw = "cd ~/Work && cls";
      cdc = "cd ~/Code && cls";
      cdd = "cd ~/Desktop && cls";

      # Nix-related utilities:
      nd = "nix develop '.#' --command ${pkgs.fish}";
      ncfg = "code ${homeDirectory}/ncfg";
    };

    functions = {
      fish_command_not_found = {
        body = ''
          echo "'$argv[1]' not found" 1>&2
        '';
        onEvent = "fish_command_not_found";
      };
    };

    shellInit = ''
      set fish_greeting
    '';
  };
}
