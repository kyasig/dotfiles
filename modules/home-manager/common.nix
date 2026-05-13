{ pkgs, ... }:
{
  imports = [
    ./xmonad.nix
    ./xmobar.nix
    ./shell.nix
    ./kitty.nix
    ./neovim.nix
    ./zathura.nix
    ./librewolf.nix
    ./rofi.nix
    ./bemenu.nix
    ./qutebrowser.nix
  ];
  home = {
    homeDirectory = "/home/ky";
    stateVersion = "26.05";
    packages = with pkgs; [
      texliveFull
      gtk4
    ];
    pointerCursor = {
      enable = true;
      x11.enable = true;
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };
  services.dunst.enable = true;
  programs.home-manager.enable = true;
}
