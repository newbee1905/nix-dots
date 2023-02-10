{ config, pkgs, ... }:

{
	imports = [
		./pkgs/gui/discord
		./pkgs/editor/neovim
	];

	home.packages = with pkgs; [
		# Terminal
		git
		btop
		zsh
		xclip
		fd
		du-dust
		exa

		# window manager
		qtile

		# applications
		# neovim-nightly
		# discord
		wezterm
		# nixgl
		nixgl.nixGLIntel
		macchina
		pulsemixer
		pamixer
		flameshot

		# languages
		nodejs
		nodePackages.npm
		yarn
		nodePackages.pnpm
		llvm
		gcc

		# Utilities
		ibus
		ibus-engines.bamboo
	];


	home.extraOutputsToInstall = [ "man" ];

	programs = {
		home-manager.enable = true;

		git = {
			enable = true;
			userName = "newbee1905";
			userEmail = "beenewminh@outlook.com";
		};
	};
}
