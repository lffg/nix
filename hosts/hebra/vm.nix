{
  options,
  lib,
  vars,
  ...
}:
lib.mkIf (options ? virtualisation.memorySize) {
  users.users.${vars.user.name}.password = "test";
}
