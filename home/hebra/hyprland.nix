{pkgs, ...}: let
  inherit (builtins) map toString;
  inherit (pkgs.lib) range;
  inherit (pkgs.lib.lists) flatten;

  flatValues = set: flatten (pkgs.lib.attrsets.attrValues set);
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
}
