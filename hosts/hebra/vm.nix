{
  options,
  lib,
  ...
}:
lib.mkIf (options ? virtualisation.memorySize) {
  users.users.luiz.password = "test";
}
