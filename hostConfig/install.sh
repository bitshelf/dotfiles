#!/bin/bash

function install_host {
	echo "source ${PWD}/terminal.sh" >> ~/.bashrc
	ln -sf ${PWD}/vimrc ~/.vimrc
	ln -sf ${PWD}/gitconfig ~/.gitconfig
	ln -sf ${PWD}/rustconfig ~/.cargo/config
	ln -sf ${PWD}/coc-settings.json	 ~/.vim/coc-settings.json
}

function install_rs {
	./cargo.sh
}

function install_all {
	install_host
	install_rs
}

function install_nvim {
	pushd ../neovim/
	make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local/
	make install
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
