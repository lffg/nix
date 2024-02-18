{
  config,
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  imports = let
    commonModules = [
      ../shared/nix.nix
      ./fonts.nix
      ./pkgs.nix
      ./git.nix
      ./vscode.nix
      ./security.nix
      ./fish.nix
      ./starship.nix
    ];
    hostModules = import (./. + "/${vars.host.name}" + /default.nix);
  in
    commonModules ++ hostModules;

  home = {
    username = vars.user.name;
    homeDirectory = vars.user.home;

    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;
}
