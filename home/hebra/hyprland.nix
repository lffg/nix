{
  config,
  pkgs,
  inputs,
  ...
}: let
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

  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us";
      kb_variant = "intl";
    };

    bind = flatValues {
      main = [
        "super, q, killactive"
        "super, f, togglefloating"
        "super, g, fullscreen"

        "super, left, movefocus, l"
        "super, right, movefocus, r"
        "super, up, movefocus, u"
        "super, down, movefocus, d"

        "super, s, togglespecialworkspace, magic"
        "super shift, s, movetoworkspace, special:magic"
      ];

      launchers = let
        inherit (config) programs;
        alacritty = "${programs.alacritty.package}/bin/alacritty";
        wofi = "${pkgs.wofi}/bin/wofi";
      in [
        "super, t, exec, ${alacritty}"
        "super, r, exec, ${wofi} --show drun"
      ];

      audio = let
        pactl = "${pkgs.pulseaudio}/bin/pactl";
      in [
        ", XF86AudioRaiseVolume, exec, ${pactl} set-sink-volume @DEFAULT_SINK@   +5%"
        ", XF86AudioLowerVolume, exec, ${pactl} set-sink-volume @DEFAULT_SINK@   -5%"
        ", XF86AudioMute,        exec, ${pactl} set-sink-mute   @DEFAULT_SINK@   toggle"
        "shift, XF86AudioMute,   exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];

      screenshot = let
        # TODO: Maybe use overlay in home-manager's main definition?
        grimblast = "${inputs.hyprland-contrib.packages.${pkgs.system}.grimblast}/bin/grimblast";
      in [
        "super, p, exec, ${grimblast} --notify --freeze copy area"
      ];

      # Switch to workspace and move to workspace binds.
      workspaces = let
        f = n: [
          "super, ${n}, workspace, ${n}"
          "super shift, ${n}, movetoworkspace, ${n}"
        ];

        absolute = flatten (map (n: f (toString n)) (range 1 9));

        relative = [
          "super shift, left, workspace, -1"
          "super shift, right, workspace, +1"
          "r_control, left, workspace, -1"
          "r_control, right, workspace, +1"
        ];
      in
        absolute ++ relative;
    };

    bindm = let
      mouseLeft = "272";
      mouseRight = "273";
    in [
      "super, mouse:${mouseLeft}, movewindow"
      "super, mouse:${mouseRight}, resizewindow"
    ];

    bindl = flatValues {
      lid-toggle = let
        switch = "Lid Switch";
      in [
        # Confusingly, off->open and on->closed.
        ", switch:off:${switch}, exec, hyprctl keyword monitor '${monitorConfigs.laptop}'"
        ",  switch:on:${switch}, exec, hyprctl keyword monitor '${monitors.laptop.name}, disable'"
      ];
    };

    monitor = attrValues monitorConfigs;

    misc = {
      force_default_wallpaper = "0";
    };
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
