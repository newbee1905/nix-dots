{
	pkgs,
	flakePkgs,
	inputs,
	lib,
	...
}: let
	neovim-unwrapped = pkgs.neovim-nightly;
	
	# Nvim needs a lot of things in $PATH; don't install them globally just because of that.
	neovim-wrapped = pkgs.callPackage ./neovim.nix {
		inherit neovim-unwrapped;
	};

	# neovimConfig = pkgs.callPackage ./config.nix { src = inputs.dotfiles; };
in {
	home.packages = [neovim-wrapped];

	# home.file.".config/nvim".source = neovimConfig;
}
