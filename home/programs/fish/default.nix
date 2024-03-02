{
  pkgs,
  config,
  vars,
  lib,
  ...
}: let
  inherit (pkgs.lib) optionalString;
  inherit (pkgs.stdenv) isDarwin;
  inherit (config.home) homeDirectory;
in {
  # XX: Maybe I should just give up and use nix-darwin
  # with a declarative Homebrew integration?
  home.file.".zshrc".text = ''
    [[ -f /opt/homebrew/bin/brew ]] &&\
      eval "$(/opt/homebrew/bin/brew shellenv)"

    exec fish
  '';

  programs.fish = {
    enable = true;

    shellAliases = {
      psqll = "PAGER='less -S' psql";

      nd = "nix develop '.#' --command ${pkgs.fish}/bin/fish";
    };

    shellAbbrs = {
      # General commands:
      g = "git";
      cls = "clear";

      p = "pnpm";

      # Typos:
      "cd.." = "cd ..";
      "code." = "code .";

      # Navigation
      cdw = "cd ~/Work && clear";
      cdc = "cd ~/Code && clear";
      cdd = "cd ~/Desktop && clear";

      # Nix-related utilities:
      ncfg = "code ${homeDirectory}/ncfg";
      xx = let
        cmd =
          if isDarwin
          then "home-manager switch"
          else "sudo nixos-rebuild switch";
      in "${cmd} --flake '${homeDirectory}/ncfg'";
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

    interactiveShellInit = let
      fix-flake-path = pkgs.writeShellApplication {
        name = "fix-flake-path";
        text = builtins.readFile ./fix-flake-path.sh;
      };

      # HACK
      # ====
      #
      # For some reason some specific-darwin paths (such as `/usr/local/bin`)
      # are *prepended* when a new shell is opened, which overrides the specific
      # paths that are defined when one enters a Nix flake dev shell.
      #
      # This tiny scripts changes those orders to prioritize paths that start
      # with "/nix/store/".
      darwinShellInit = ''
        export PATH="$(${fix-flake-path}/bin/fix-flake-path)"
      '';
    in ''
      ${optionalString isDarwin darwinShellInit}
    '';
  };
}
