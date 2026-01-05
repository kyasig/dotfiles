{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/virtualization.nix
  ];
  powerManagement.enable = true;
  services.tlp.enable = true;
}
