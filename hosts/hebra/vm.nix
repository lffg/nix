{
  options,
  lib,
  vars,
  ...
}: {
  imports = [
    (lib.mkIf (options ? virtualisation.memorySize) {
      users.users.${vars.user.name}.password = "test";
    })
  ];

  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
