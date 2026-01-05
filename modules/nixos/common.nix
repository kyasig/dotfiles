{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./audio.nix
    ./nix.nix
    ./auth.nix
    ./stylix.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "sig";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;

  services.xserver.xkb.layout = "us";
  services.xserver.windowManager.xmonad.enable = true;

  services.printing.enable = true;

  services.libinput.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.ky = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      rofi
      lazygit
      nixfmt-rfc-style
    ];
  };
  environment.systemPackages = with pkgs; [
    neovim
    git
    xclip
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.nano.enable = false;

  system.stateVersion = "26.05";

}
