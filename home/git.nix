{pkgs, ...}: let
  inherit (pkgs.lib) concatStringsSep;
in {
  programs.git = {
    enable = true;

    userName = "Luiz Felipe Gonçalves";
    userEmail = "git@luizfelipe.dev";

    # signing = {
    #   signByDefault = true;
    #   key = "...";
    # };

    extraConfig = {
      core = {
        ignorecase = "false";
        editor = "${pkgs.vim}/bin/vim";
      };

      pull.rebase = "true";
      init.defaultBranch = "main";

      # commit.gpgsign = "true";
      # gpg.program = "gpg2";

      # protocol.keybase.allow = "always";
      # credential.helper = "osxkeychain";

      # user = {
      #   signingkey = "63391D9963236F36";
      # };
    };

    delta.enable = true;

    aliases = {
      l = "log --oneline";

      c = "commit";
      ca = "commit --amend";
      cane = "commit --amend --no-edit";

      su = "stash push";
      sus = "stash push --staged";
      sp = "stash pop";

      rh1 = "reset HEAD^";

      r = "rebase";
      rc = "rebase --continue";
      ra = "rebase --abort";

      pushd = "!git push -u origin $(git rev-parse --abbrev-ref HEAD)";
      pushf = "push --force-with-lease";

      clean-all-branches = concatStringsSep "|" [
        "!git branch --list"
        "grep -e __no-clean__ -e develop -e main -e master -e '*' -v"
        "xargs -I {} git branch -D {}"
      ];
    };
  };
}
