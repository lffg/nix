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

    shellInit = ''
      set fish_greeting

      function __fish_default_command_not_found_handler --on-event fish_command_not_found
        functions --erase __fish_command_not_found_setup
        echo "'$argv' not found"
      end
    '';
  };
}
