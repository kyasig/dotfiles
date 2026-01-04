{
  description = "kyasig's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs,...}:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      victus = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/victus
          ./modules/nixos/configuration.nix
        ];
      };
    };
  };
}

