{
  description = "my config fuck you";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware = {
      url = "github:NixOS/nixos-hardware";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		nur = {
			url = "github:nix-community/NUR";
		};
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    hardware,
    nixvim,
		nur,
    ...
  }: {
    nixosConfigurations = {
      aya = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./aya-hardware-configuration.nix
          ./aya.nix
          ./configuration.nix
          ./wireguard/aya.nix
					nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            # home-manager.users.lw = (import ./lw.nix) "aya";
            home-manager.users.lw.imports = [
              nixvim.homeManagerModules.nixvim
              ((import ./lw.nix) "aya")
						];
          }
          hardware.nixosModules.lenovo-thinkpad-e14-amd
        ];
      };
      rin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./rin-hardware-configuration.nix
          ./rin.nix
          ./configuration.nix
					nur.nixosModules.nur
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.users.lw.imports = [
              nixvim.homeManagerModules.nixvim
              ((import ./lw.nix) "aya")
            ];
          }
        ];
      };
    };
  };
}
