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
  boot.tmp.cleanOnBoot = true;

  networking.hostName = "sig";

  networking.networkmanager.enable = true;
  networking.networkmanager.settings = {
    connectivity = {
      enabled = true;
      uri = "http://neverssl.com";
      interval = 300;
      response = "success";
    };
  };
  programs.nm-applet.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;

  services.xserver.xkb.layout = "us";
  services.xserver.windowManager.xmonad.enable = true;

  services.displayManager.ly.enable = true;

  services.printing.enable = true;
  services.libinput.enable = true;
  services.udisks2.enable = true;
  services.openssh.enable = true;
  services.xbanish.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.ky = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
      "adbusers"
    ];
    packages = with pkgs; [
      lazygit
      nixfmt-rfc-style
      networkmanagerapplet
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

  services.dbus.enable = true;
  system.stateVersion = "26.05";

}
