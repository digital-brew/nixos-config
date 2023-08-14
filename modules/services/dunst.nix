{ config, lib, pkgs, ... }:
let 

in 
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 1;
        follow = "none";
        indicate_hidden = true;
        shrink = false;
        transparency = 0;
        separator_height = 2;
        padding = 14;
        horizontal_padding = 14;
        frame_width = 2;
        frame_color = "#29293e";
        separator_color = "frame";
        sort = true;
        idle_threshold = 60;
        font = "Ubuntu 11";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        word_wrap = true;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 32;
      };
      experimental = {
        per_monitor_dpi = true;
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        highlight  = "#cdd6f4";
        timeout = 1;
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        highlight  = "#cdd6f4";
        timeout = 2;
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        highlight  = "#cdd6f4";
        timeout = 3;
      };
    };
  };
}