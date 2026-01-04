{
  description = "kyasig's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixmobar.url = "git+https://codeberg.org/xmobar/xmobar.git/?dir=nix";
  };
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        victus = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            ./hosts/victus
            ./modules/nixos/common.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit pkgs inputs;
                };
                users.ky = {
                  imports = [
                    ./modules/home-manager/home.nix
                    inputs.nixmobar.homeModules.mainmodule
                    inputs.nixvim.homeModules.nixvim
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
