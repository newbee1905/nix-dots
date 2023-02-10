{
	description = "Home Manager configuration of newbee/Kodokuna Hachi";

	inputs = {
		nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

		# Specify the source of Home Manager and Nixpkgs.
		nixpkgs-unfree = {
			url = github:numtide/nixpkgs-unfree;
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager = {
			url = github:nix-community/home-manager;
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# neovim-nightly.url = github:nix-community/neovim-nightly-overlay;
		neovim-nightly = {
			url = github:nix-community/neovim-nightly-overlay;
			# Pin to a nixpkgs revision that doesn't have NixOS/nixpkgs#208103 yet
			inputs.nixpkgs.url = github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836;
		};
		nixgl.url = github:guibou/nixGL;
	};

	nixConfig = {
		# Optionally, pull pre-built binaries from this project's cache
		extra-substituters = [ "https://numtide.cachix.org" ];
		extra-trusted-public-keys = [ "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE=" ];
	};

	outputs = inputs @ { nixpkgs, home-manager, neovim-nightly, nixgl, ... }:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;

				config = {
					allowUnfree = true;
				};

				overlays = [
					neovim-nightly.overlay
					nixgl.overlay
					(import ./overlays/discord.nix)
				];
			};
		in {
			packages.${system}.default = home-manager.defaultPackage.${system};

			homeConfigurations.newbee = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;


				# Specify your home configuration modules here, for example,
				# the path to your home.nix.
				modules = [ 
					./home.nix 
					{
						home = {
							username = "newbee";
							homeDirectory = "/home/newbee";
							stateVersion = "22.11";
						};
					}
				];

				# Optionally use extraSpecialArgs
				# to pass through arguments to home.nix
			};
		};
}
