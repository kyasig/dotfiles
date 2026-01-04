{ pkgs, ... }:
{
  imports = [
    ./xmonad.nix
    ./xmobar.nix
    ./shell.nix
    ./kitty.nix
    ./neovim.nix
    ./zathura.nix
  ];
  home = {
    #username = ky;
    homeDirectory = "/home/ky";
    stateVersion = "26.05";
    packages = with pkgs; [
      discord
      thunderbird
      texliveFull
    ];
  };
  programs.home-manager.enable = true;
}
