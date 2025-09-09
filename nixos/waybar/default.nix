{
  mainBar = {
    layer = "top";
    position = "bottom";
    height = 32;

    modules-left = ["hyprland/workspaces" "hyprland/window"];
    modules-right = ["cpu" "memory" "pulseaudio" "network" "battery" "hyprland/language" "tray" "clock"];

    "hyprland/window" = {
      icon = true;
    };

    pulseaudio = {
      format = "  {volume:3}%";
    };

    cpu = {
      interval = 1;
      format = "  {usage:3}% @ {avg_frequency:>3.1f}";
    };

    memory = {
      interval = 1;
      format = "  {used:>4.1f}/{swapUsed:>4.1f}";
    };

    network = {
      interval = 5;
      format-ethernet = "  {ipaddr}";
      format-wifi = "  {essid} @ {signaldBm:2}";
    };

    battery = {
      format = "  {time:>} @ {capacity:3}%";
    };

    "hyprland/language" = {
      format = "{short:>}";
    };
  };
}
