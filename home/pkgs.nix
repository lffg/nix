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

    nodejs_20
    nodePackages.pnpm

    # Programming language tools
    alejandra
  ];
}
