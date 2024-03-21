{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
  ];

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    rustflags = [
      "-C", "linker=${pkgs.clang}/bin/clang",
      "-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold",
    ]
  '';
}
