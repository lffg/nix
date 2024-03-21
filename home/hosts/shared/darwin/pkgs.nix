{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = let
    frameworks = with pkgs.darwin.apple_sdk.frameworks; [
      CoreFoundation
      CoreServices
      SystemConfiguration
    ];

    packages = with pkgs; [
      pkgs-unstable.podman
      pkgs-unstable.qemu
    ];
  in
    frameworks ++ packages;
}
