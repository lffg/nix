{
  config,
  pkgs,
  ...
}: {
  services.dunst.enable = true;

  home.packages = [
    pkgs.libnotify
    config.services.dunst.package
  ];
}
