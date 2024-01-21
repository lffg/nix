{
  pkgs,
  config,
  ...
}: let
  home = config.home.homeDirectory;
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
      ncfg = "code ${home}/ncfg";
    };
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
