{
  config,
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  imports = let
    commonModules = [
      ./fonts.nix
      ./pkgs.nix
      ./git.nix
      ./vscode.nix
      ./fish.nix
    ];
    hostModules = import (./. + "/${vars.host.name}" + /default.nix);
  in
    commonModules ++ hostModules;

  home = rec {
    username = vars.user.name;
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;
}
