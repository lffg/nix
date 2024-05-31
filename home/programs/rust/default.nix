{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    rustup
    llvmPackages.clang
    pkg-config
    libiconv
  ];

  home.sessionVariables = let
    inherit (lib.strings) makeLibraryPath;
  in {
    LIBRARY_PATH = makeLibraryPath (with pkgs; [
      libiconv
    ]);
  };

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    rustflags = [
      "-C", "linker=${pkgs.clang}/bin/clang",
      "-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold",
    ]
  '';
}
