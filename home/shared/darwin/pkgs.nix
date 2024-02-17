{pkgs, ...}: {
  home.packages = let
    frameworks = with pkgs.darwin.apple_sdk.frameworks; [
      CoreFoundation
      CoreServices
      SystemConfiguration
    ];

    packages = with pkgs; [
      # Don't ask me why this worked
      llvmPackages.clang-unwrapped
      llvmPackages.bintools
      pkg-config
      libiconv
    ];
  in
    frameworks ++ packages;
}
