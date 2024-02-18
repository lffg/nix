{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  programs.starship = {
    enable = true;

    enableFishIntegration = mkIf config.programs.fish.enable true;
    enableZshIntegration = mkIf config.programs.zsh.enable true;

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

      c.disabled = true;
      elixir.disabled = true;
      nodejs.disabled = true;
      python.disabled = true;
      rust.disabled = true;
    };
  };
}
