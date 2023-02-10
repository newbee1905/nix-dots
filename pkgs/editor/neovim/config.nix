{
	src,
	stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
	name = ".config/nvim";
	inherit src;

	dontConfigure = true;
	dontBuild = true;

	installPhase = ''
		mkdir -p $out
		cp -a nvim/* $out/
	'';
}
