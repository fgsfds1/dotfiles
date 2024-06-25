{
  background = {
    monitor = "";
    path = "/home/lw/Pictures/wp_aya.jpg";
    blur_passes = 4;
    blur_size = 3;
    brightness = 0.7;
    contrast = 0.7;
  };

  input-field = {
    monitor = "";
    size = "350, 50";
    outline_thickness = 3;
    dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = false;
    dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
    outer_color = "rgb(151515)";
    inner_color = "rgb(200, 200, 200)";
    font_color = "rgb(10, 10, 10)";
    fade_on_empty = true;
    fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
    placeholder_text = "<i>go away</i>"; # Text rendered in the input box when it's empty.
    hide_input = false;
    rounding = 10; # -1 means complete rounding (circle/oval)
    check_color = "rgb(204, 136, 34)";
    fail_color = "rgb(204, 34, 34)"; # if authentication failed, changes outer_color and fail message color
    fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
    fail_transition = 300; # transition time in ms between normal outer_color and fail_color
    capslock_color = -1;
    numlock_color = -1;
    bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
    invert_numlock = false; # change color if numlock is off
    swap_font_color = false; # see below

    position = "0, 0";
    valign = "center";
    halign = "center";
  };
}
