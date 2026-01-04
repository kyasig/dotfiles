{ config, ... }:
{
  programs.nixmobar =
    let
      bg = "#161616";
      fg = "#ffffff";
      color1 = "#262626";
      color2 = "#393939";
      color3 = "#525252";
      color4 = "#dde1e6";
      color6 = "#f2f4f8";
      color7 = "#08bdba";
      color8 = "#3ddbd9";
      color9 = "#78a9ff";
      colorA = "#ee5396";
      colorB = "#33b1ff";
      colorC = "#ff7eb6";
      colorD = "#42be65";
      colorE = "#be95ff";
      colorF = "#82cfff";
    in
    {
      enable = true;
      bgColor = bg;
      fgColor = fg;
      position = "TopSize L 100 27";
      allDesktops = true;
      #sepChar = "%";
      alignSep = "}{";
      alpha = 255;
      template = "  %UnsafeXMonadLog% }{<fc=${color9}> </fc>%memory% <fc=${colorA}> </fc>%cpu% <fc=${colorB}> </fc>%uptime% <fc=${colorC}> </fc>%disku% <fc=${color8}> </fc>%default:Master% <fc=${colorD}> </fc>%battery% <fc=${colorE}> </fc>%date% ";
      commands = 
        ''
            Run Cpu ["-t", "<total>%"] 10
          , Run Memory ["-t","<used>m used"] 10
          , Run Date "%b %d (%a) %r" "date" 10
          , Run BatteryP ["ACAD", "BAT0", "hidpp_battery_0"] ["-t", "<left>%"] 3
          , Run Uptime ["-t","<days>d <hours>h <minutes>m"] 10
          , Run DiskU [("/","<free> free")] [] 3000
          , Run Volume "default" "Master" ["-t", "<volume>%<status>",
                                          "--",
                                          "-O", "",
                                          "-o", "[Muted]",
                                          "-c", "${colorA}"
                                          ] 10
          , Run UnsafeXMonadLog
        '';
    };
}
