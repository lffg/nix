{pkgs, ...}: {
  # GPG
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  # Git signing
  programs.git = {
    signing = {
      signByDefault = true;
      key = "E1FEC20C853E9736";
    };
    extraConfig = {
      commit.gpgsign = true;
      gpg.program = "${pkgs.gnupg}/bin/gpg2";
      credential.helper = "${pkgs.gnome.gnome-keyring}";
    };
  };

  # Programs
  services.gnome-keyring.enable = true;
  home.packages = [
    pkgs.gnome.gnome-keyring
    pkgs.gnome.seahorse
  ];
}
