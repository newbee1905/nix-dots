{
	alejandra,
	curl,
	fd,
	fzf,
	git,
	lib,
	makeWrapper,
	neovim-unwrapped, # flake
	nodePackages,
	nodejs,
	perl,
	python3,
	ripgrep,
	rnix-lsp,
	shellcheck,
	shfmt,
	stdenv,
	stylua,
	sumneko-lua-language-server,
	symlinkJoin,
	tree-sitter,
	xclip,
}:
symlinkJoin {
	name = "neovim";
	paths = [neovim-unwrapped];
	buildInputs = [makeWrapper];
	postBuild = let
		python = python3.withPackages (pp: with pp; [pynvim black]);
		path =
			[
				curl
				fd
				fzf
				git
				nodejs
				perl
				python
				ripgrep
				stdenv.cc
				tree-sitter

				# Linters
				shellcheck

				# Formatters
				stylua
				alejandra
				nodePackages.prettier
				shfmt

				# Language servers
				sumneko-lua-language-server
				nodePackages.pyright
				rnix-lsp
			]
			++ lib.optionals (!stdenv.isDarwin) [
				xclip
			];
	in ''
		wrapProgram $out/bin/nvim\
			--prefix PATH : ${lib.makeBinPath path} \
			--set LD_LIBRARY_PATH ${stdenv.cc.cc.lib}/lib
	'';
}
