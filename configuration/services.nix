{ pkgs, home, ... }:
{
  services.postgresql = {
    package = pkgs.postgresql_15;
    enable = true;
    authentication = ''
      local   all             all                                     trust
      host    all             all             0.0.0.0/0               trust
      host    all             all             ::1/128                 trust
    '';

    enableTCPIP = true;
  };

  # services.spacebar.enable = false;
  # services.spacebar.package = pkgs.spacebar;
  # services.spacebar.config = {
  #   position                   = "top";
  #   display                    = "main";
  #   height                     = 32;
  #   title                      = "off";
  #   clock                      = "on";
  #   power                      = "on";
  #   padding_left               = 20;
  #   padding_right              = 20;
  #   spacing_left               = 25;
  #   spacing_right              = 15;
  #   text_font                  = ''"Mononoki Nerd Font:Regular:12.0"'';
  #   icon_font                  = ''"Mononoki Nerd Font:Regular:14.0"'';
  #   background_color           = "0xff0b0b0b";
  #   foreground_color           = "0xffa8a8a8";
  #   power_icon_color           = "0xffcd950c";
  #   battery_icon_color         = "0xffd75f5f";
  #   dnd_icon_color             = "0xffa8a8a8";
  #   clock_icon_color           = "0xffa8a8a8";
  #   power_icon_strip           = " ";
  #   space_icon_color           = "0xffe78a4e";
  #   space_icon_color_secondary = "0xff78c4d4";
  #   space_icon_color_tertiary  = "0xfffff9b0";
  #   clock_icon                 = "";
  #   clock_format               = ''"%d/%m/%y  %R"'';
  # };

  services.sketchybar.enable = true;

  # Direct log output to $XDG_DATA_HOME/postgresql for debugging.
  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "${home}/.local/share/postgresql/postgres.error.log";
    StandardOutPath = "${home}/.local/share/postgresql/postgres.out.log";
  };
}
