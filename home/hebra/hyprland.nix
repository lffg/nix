{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  wayland.windowManager.hyprland.settings = let
    s = "SUPER";
  in {
    input = {
      kb_layout = "us";
      kb_variant = "intl";
    };
    bind = let
      alacritty = "${pkgs.alacritty}/bin/alacritty";
      wofi = "${pkgs.wofi}/bin/wofi";
    in [
      "${s}, Q, killactive"
      "${s}, T, exec, ${alacritty}"
      "${s}, R, exec, ${wofi} --show drun"
    ];
    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "${s}, mouse:272, movewindow"
      "${s}, mouse:273, resizewindow"
    ];
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
    configPackages = [pkgs.hyprland];
  };

  home.packages = with pkgs; [
    # Bar
    waybar
    # Notifications
    dunst
    libnotify
    # App launcher
    wofi
  ];
}
