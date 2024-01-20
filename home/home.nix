{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./hebra/hyprland.nix
    ./fonts.nix
    ./git.nix
  ];

  home = {
    username = "luiz";
    homeDirectory = "/home/luiz";

    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;
  };

  home.packages = with pkgs; [
    # Command-line tools
    git
    vim
    neovim

    # Applications, GUIs, etc
    alacritty
    logseq
    brave
    spotify

    # Programming languages, toolchains, and compilers
    rustup
    clang
    nodejs
    (pkgs-unstable.elixir_1_16.override {
      erlang = pkgs-unstable.erlang_26;
    })

    # Programming language tools
    alejandra
  ];

  programs.home-manager.enable = true;

  programs.vscode.enable = true;
}
