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

    pkgs-unstable.go
    pkgs-unstable.gopls

    jdk

    nodejs_20
    pkgs-unstable.nodePackages.pnpm
    pkgs-unstable.nodePackages.yarn

    # Programming language tools
    alejandra

    # Other
    ledger
  ];
}
