{config, ...}: {
  services.playerctld.enable = true;

  home.packages = [
    config.services.playerctld.package
  ];
}
