{
  config,
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  imports = [
    ./hebra/hyprland.nix
    ./fonts.nix
    ./pkgs.nix
    ./git.nix
    ./vscode.nix
    ./zsh.nix
  ];

  home = rec {
    username = vars.user.name;
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;
}
