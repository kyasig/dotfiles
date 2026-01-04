{ pkgs, user, inputs,... }:
{
  imports = [
    ./xmonad.nix
    ./xmobar.nix
    ./kitty.nix
  ];
  home = {
    #username = ky;
    homeDirectory = "/home/ky";
    stateVersion = "26.05";
    packages = with pkgs; [
    ];
  };
  programs.home-manager.enable = true;
}
