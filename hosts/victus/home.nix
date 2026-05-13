{ pkgs, ... }:
{
  imports = [
    ../../modules/home-manager/common.nix
  ];
  home = {
    packages = with pkgs; [
      discord
      thunderbird
      texliveFull
      freetube
      telegram-desktop
      gap-full
      brave
      transmission_4-gtk
      bitwarden-desktop
    ];
  };
}
