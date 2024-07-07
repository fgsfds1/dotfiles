host: let
  monitor_scale = (import ./${host}.nix).monitor_scale;
in {
  #host_config = import ./${host}.nix;
  monitor = ",preferred,auto,${toString monitor_scale}";
  #monitor = ",preferred,auto,1.25";

  "$terminal" = "alacritty";
  "$fileManager" = "dolphin";
  "$menu" = "rofi";
  "$menuargs" = "-show drun -show-icons";
  "$browser" = "firefox";
  "$locker" = "hyprlock --immediate";
  "$startscript" = "~/.config/hypr/start.sh";
  "$hostscript" = "~/.config/hypr/host.sh";

  env = [
    "XCURSOR_SIZE,64"
    "HYPRCURSOR_SIZE,64"
    "HYPRSHOT_DIR,/home/lw/Pictures/screenshots"
  ];

  general = {
    gaps_in = 2;
    gaps_out = 5;
    border_size = 2;

    "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";

    resize_on_border = true;

    allow_tearing = false;

    layout = "dwindle";
  };

  dwindle = {
    no_gaps_when_only = 1;
    # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    pseudotile = true;
    # You probably want this
    preserve_split = true;
  };

  decoration = {
    rounding = 5;

    active_opacity = 1.0;
    inactive_opacity = 0.9;

    drop_shadow = true;
    shadow_range = 4;
    shadow_render_power = 3;
    "col.shadow" = "rgba(1a1a1aee)";

    blur = {
      enabled = true;
      size = 3;
      passes = 1;

      vibrancy = 0.1696;
    };
  };

  animations = {
    enabled = true;

    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

    animation = [
      "windows, 1, 4, myBezier"
      "windowsOut, 1, 4, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 4, default"
      "workspaces, 1, 4, default"
    ];
  };

  misc = {
    force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
  };

  input = {
    kb_layout = "us, ru";
    #kb_variant =
    #kb_model =
    kb_options = "grp:caps_toggle";
    #kb_rules =

    follow_mouse = 1;

    sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

    touchpad = {
    };
  };

  # https://wiki.hyprland.org/Configuring/Variables/#gestures
  gestures = {
    workspace_swipe = false;
  };

  # Example per-device config
  # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
  device = [
    {
      name = "epic-mouse-v1";
      sensitivity = -0.5;
    }
    {
      name = "etps/2-elantech-touchpad";
      enabled = false;
    }
  ];

  "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

  # These are just regular binds
  bind = [
    "$mainMod, Q, killactive"
    "$mainMod SHIFT, Q, killactive"
    "$mainMod, Return, exec, $terminal"
    "$mainMod, E, exec, $fileManager"
    "$mainMod, b, exec, $browser"
    "$mainMod, f, togglefloating,"
    "$mainMod, P, pseudo," # dwindle
    "$mainMod SHIFT, K, exit"

    "$mainMod, left, movefocus, l"
    "$mainMod, right, movefocus, r"
    "$mainMod, up, movefocus, u"
    "$mainMod, down, movefocus, d"

    "$mainMod, h, movefocus, l"
    "$mainMod, l, movefocus, r"
    "$mainMod, k, movefocus, u"
    "$mainMod, j, movefocus, d"
    "$mainMod SHIFT, h, movewindow, l"
    "$mainMod SHIFT, l, movewindow, r"
    "$mainMod SHIFT, k, movewindow, u"
    "$mainMod SHIFT, j, movewindow, d"

    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod, 6, workspace, 6"
    "$mainMod, 7, workspace, 7"
    "$mainMod, 8, workspace, 8"
    "$mainMod, 9, workspace, 9"
    "$mainMod, 0, workspace, 10"

    "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
    "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
    "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
    "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
    "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
    "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
    "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
    "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
    "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
    "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

    "$mainMod, S, togglespecialworkspace, magic"
    "$mainMod SHIFT, S, movetoworkspace, special:magic"

    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"

    ", PRINT, exec, hyprshot -m region"
  ];

  # Binds that work on the lockscreen
  bindl = [
  ];

  # Binds that open/close programs
  bindr = [
    "$mainMod, R, exec, pkill $menu || $menu $menuargs"
  ];

  # Mouse binds
  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  # Binds that work on lockscreen (l) and can repeat (e)
  bindel = [
    ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
    ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
    ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
    ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    "$mainMod, semicolon, exec, $locker"
    ", switch:Lid Switch, exec, $locker"
  ];

  windowrulev2 = "suppressevent maximize, class:.*"; # You'll probably like this.

  exec-once = ["bash $startscript" "bash $hostscript"];
  # exec-once = $terminal
  # exec-once = nm-applet &
  # exec-once = waybar & hyprpaper & firefox
}
