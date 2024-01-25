{
  pkgs,
  config,
  ...
}: let
  inherit (pkgs.lib.strings) concatStringsSep;
  inherit (pkgs.stdenv) isLinux;

  maybeString = pred: s:
    if pred
    then s
    else "";

  inherit (config.home) homeDirectory username;
in {
  programs.zsh = {
    enable = true;

    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;

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
      nd = "nix develop '.#' --command ${pkgs.zsh}";
      ncfg = "code ${homeDirectory}/ncfg";
    };

    initExtra = concatStringsSep "\n\n" [
      (maybeString isLinux ''
        unset __HM_SESS_VARS_SOURCED
        . /etc/profiles/per-user/${username}/etc/profile.d/hm-session-vars.sh
      '')
    ];
  };

  programs.starship = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      gcloud = {
        disabled = false;
        format = "(on [$symbol($account )(\($project\) )]($style))";
      };

      nix_shell = {
        disabled = false;
        format = "via [$symbol(\($name\))](blue bold) ";
      };

      package.disabled = true;
      line_break.disabled = false;

      rust.disabled = true;
      elixir.disabled = true;
      nodejs.disabled = true;
      c.disabled = true;
      python.disabled = true;
    };
  };
}
