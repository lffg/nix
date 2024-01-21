{
  config,
  pkgs,
  pkgs-unstable,
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

  home = {
    username = "luiz";
    homeDirectory = "/home/luiz";

    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;
}
