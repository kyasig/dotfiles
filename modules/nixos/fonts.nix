{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      #font-awesome
      mononoki
      nerd-fonts.jetbrains-mono
    ];
  };
}
