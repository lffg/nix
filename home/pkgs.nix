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
    shellcheck
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

    go
    gopls

    nodejs_20
    nodePackages.pnpm

    # Programming language tools
    alejandra
  ];
}
