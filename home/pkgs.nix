{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./pkgs/pg.nix
  ];

  home.packages = with pkgs; [
    # Command-line tools
    git
    vim
    neovim
    bat
    eza
    htop
    httpie
    gnutar
    zstd
    coreutils
    curl
    jq
    hexyl
    tokei

    # Applications, GUIs, etc
    pkgs-unstable.logseq
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
