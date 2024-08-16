{pkgs, ...}: let
  gcp = pkgs.writeShellApplication {
    name = "gcp";
    text = builtins.readFile ./gcp.sh;
    runtimeInputs = [pkgs.google-cloud-sdk];
  };
in {
  home.packages = [
    pkgs.google-cloud-sdk # This is not actually necessary for the `gcp` util.
    gcp
  ];
}
