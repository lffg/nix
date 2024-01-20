{pkgs, pkgs-unstable, ...}: {
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
}
