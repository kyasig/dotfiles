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
  ];
  home = {
    #username = ky;
    homeDirectory = "/home/ky";
    stateVersion = "26.05";
    packages = with pkgs; [
      discord
      thunderbird
      texliveFull
      freetube
    ];
  };
  programs.home-manager.enable = true;
}
