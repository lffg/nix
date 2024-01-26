{
  config,
  pkgs,
  vars,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./vm.nix
    ./io.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0" # goddamn logseq
    ];
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  users.users = {
    ${vars.user.name} = {
      isNormalUser = true;
      description = "Luiz Felipe";
      extraGroups = ["networkmanager" "wheel"];
      packages = [];
      shell = pkgs.fish;
    };
  };

  programs.fish.enable = true;

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  networking = {
    hostName = vars.host.name;
    networkmanager.enable = true;
  };

  # Just enough packages to get stated; all other packages
  # are installed through home-manager.
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_CTYPE = "pt_BR.UTF-8"; # Fix cedilla in us-intl.
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };
}
