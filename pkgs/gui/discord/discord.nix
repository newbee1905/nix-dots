{
	lib,
	discord,
}: let
	discord-flags = [
		"--ignore-gpu-blocklist"
		"--disable-features=UseOzonePlatform"
		"--enable-features=VaapiVideoDecoder"
		"--use-gl=desktop"
		"--enable-gpu-rasterization"
		"--enable-zero-copy"
		"--no-sandbox"
	];

	discord-unwrapped = discord.override {
		withOpenASAR = true;
	};
in
	discord-unwrapped.overrideAttrs (oldAttrs: rec {
		desktopItem = oldAttrs.desktopItem.override {
			exec = "${discord-unwrapped}/bin/Discord " + lib.concatStringsSep " " discord-flags;
		};
		installPhase = builtins.replaceStrings ["${oldAttrs.desktopItem}"] ["${desktopItem}"] oldAttrs.installPhase;
	})
