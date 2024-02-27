{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./pkgs/pg.nix
    ./pkgs/openssl.nix
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
    fd
    coreutils
    curl
    jq
    hexyl
    tokei
    pkgs-unstable.ast-grep

    # Applications, GUIs, etc
    # pkgs-unstable.logseq
    # brave
    # spotify

    # Programming languages, toolchains, and compilers
    rustup
    nodejs
    (pkgs-unstable.elixir_1_16.override {
      erlang = pkgs-unstable.erlang_26;
    })

    # Programming language tools
    alejandra
  ];
}
