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
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      mkNixosConfig =
        conf: home:
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            conf
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = ".bak";
                extraSpecialArgs = {
                  inherit pkgs inputs system;
                };
                users.ky = {
                  imports = [
                    home
                    inputs.nixmobar.homeModules.mainmodule
                    inputs.nixvim.homeModules.nixvim
                  ];
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        victus = mkNixosConfig ./hosts/victus ./hosts/victus/home.nix;
        thinkpad = mkNixosConfig ./hosts/thinkpad ./hosts/thinkpad/home.nix;
      };
    };
}
