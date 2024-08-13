{
  config,
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  imports = let
    commonModules = [
      ./programs/fish/default.nix
      ./programs/rust/default.nix
      ./fonts.nix
      ./pkgs.nix
      ./git.nix
      ./security.nix
      ./starship.nix
    ];
    hostModules = import (./. + "/hosts/${vars.host.name}" + /default.nix);
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
