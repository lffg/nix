{pkgs, ...}: let
  inherit (builtins) map toString;
  inherit (pkgs.lib) range;
  inherit (pkgs.lib.lists) flatten;
  inherit (pkgs.lib.attrsets) attrValues mapAttrs mapAttrsToList;

  flatValues = set: flatten (attrValues set);

  #  ----------    --------
  # | primary  |  | laptop |
  #  ----------    --------
  monitors = rec {
    primary = {
      name = "HDMI-A-2";
      width = 1920;
      height = 1080;
      x = 0;
      scale = 1;
    };
    laptop = {
      name = "eDP-1";
      width = 3840;
      height = 2160;
      x = primary.width;
      scale = 3;
    };
  };

  monitorConfigs =
    mapAttrs (
      _: m: let
        size = "${toString m.width}x${toString m.height}";
        position = "${toString m.x}x0";
      in
        # name, resolution, position, scale
        "${m.name}, ${size}, ${position}, ${toString m.scale}"
    )
    monitors;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
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

  wayland.windowManager.hyprland.settings = let
    s = "SUPER";
  in {
    input = {
      kb_layout = "us";
      kb_variant = "intl";
    };

    bind = flatValues {
      main = let
        alacritty = "${pkgs.alacritty}/bin/alacritty";
        wofi = "${pkgs.wofi}/bin/wofi";
      in [
        "${s}, Q, killactive"
        "${s}, T, exec, ${alacritty}"
        "${s}, R, exec, ${wofi} --show drun"
      ];

      # Switch to workspace and move to workspace binds.
      workspaces = let
        f = n: [
          "${s}, ${n}, workspace, ${n}"
          "${s} SHIFT, ${n}, movetoworkspace, ${n}"
        ];
      in
        flatten (map (n: f (toString n)) (range 1 9));
    };

    bindm = let
      mouseLeft = "272";
      mouseRight = "273";
    in [
      "${s}, mouse:${mouseLeft}, movewindow"
      "${s}, mouse:${mouseRight}, resizewindow"
    ];

    bindl = flatValues {
      # TODO: Get status of `/proc/acpi/button/lid/LID/state` during startup to
      # check whether Hyprland already started with the monitor with its lid down.
      lid-toggle = let
        switch = "Lid Switch";
      in [
        # Confusingly, off->open and on->closed.
        ", switch:off:${switch}, exec, hyprctl keyword monitor '${monitorConfigs.laptop}'"
        ",  switch:on:${switch}, exec, hyprctl keyword monitor '${monitors.laptop.name}, disable'"
      ];
    };

    monitor = attrValues monitorConfigs;
  };

  home.sessionVariables = {
    # NIXOS_OZONE_WL = "1";
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
}
