{pkgs, ...}:
{
  home.packages = with pkgs;
  [
   brightnessctl
   feh
   flameshot
   xdotool
   xwallpaper
  ];
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad.hs;
  };
  services.picom = {
    enable = true;
    backend = "glx";
    };
}
