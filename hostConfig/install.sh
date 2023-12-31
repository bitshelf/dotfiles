#!/bin/bash

function install_host {
	echo "source ${PWD}/terminal.sh" >> ~/.bashrc
	ln -sf ${PWD}/vimrc ~/.vimrc
	ln -sf ${PWD}/gitconfig ~/.gitconfig
	ln -sf ${PWD}/rustconfig ~/.cargo/config
	ln -sf ${PWD}/coc-settings.json	 ~/.vim/coc-settings.json
}

function install_rust {
	# install rust
	curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh

	cargo install -f --git https://github.com/starship/starship
	cargo install ripgrep_all --locked
	cargo install --locked zellij
	./cargo.sh
}

function install_all {
	install_host
	install_rs
}

function install_nvim {
	git clone https://github.com/neovim/neovim.git
	pushd neovim/
	make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local/
	make install
	popd
}

function install_vim {
	git clone https://github.com/vim/vim.git
	pushd vim
	./configure --with-features=huge --enable-python3interp --enable-pythoninterp --prefix=$HOME/.local/ --enable-luainterp --enable-cscope --enable-multibyte
	popd
}

OPTIONS="$@"
for option in ${OPTIONS:-all}; do
	echo "start install: $option"
	case $option in
		*)
			eval install_$option
			;;
	esac
done
