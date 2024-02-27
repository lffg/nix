{pkgs, ...}: let
  inherit (pkgs) openssl;
in {
  home.packages = [openssl];

  home.sessionVariables = {
    OPENSSL_DIR = "${openssl.bin}/bin";
    OPENSSL_LIB_DIR = "${openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${openssl.out.dev}/include";
  };
}
