{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    rustup
    # llvmPackages.clang
    # pkg-config
    # libiconv
  ];

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    rustflags = [
      "-C", "linker=${pkgs.clang}/bin/clang",
      "-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold",
    ]
  '';
}
