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
  ];
  home = {
    homeDirectory = "/home/ky";
    stateVersion = "26.05";
    packages = with pkgs; [
      texliveFull
    ];
  };
  programs.home-manager.enable = true;
}
