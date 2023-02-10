{ config, pkgs, ... }:

{
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
		neovim-nightly
		discord
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
	];


	home.extraOutputsToInstall = [ "man" ];

	programs = {
		home-manager.enable = true;

		git = {
			enable = true;
			userName = "newbee1905";
			userEmail = "vuleminh1905@protonmail.com";
		};
	};
}
