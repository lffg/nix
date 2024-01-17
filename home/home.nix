{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "luiz";
    homeDirectory = "/home/luiz";

    stateVersion = "23.11";
  };

  home.packages = with pkgs; [
    # Applications, GUIs, etc
    alacritty
    logseq
    brave
    spotify

    # Programming languages, toolchains, and compilers
    rustup
    clang
    nodejs

    # Programming language tools
    alejandra
  ];

  programs.home-manager.enable = true;

  programs.vscode.enable = true;
}
