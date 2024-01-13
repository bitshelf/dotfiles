#!/bin/bash

function install_host {
	echo "source ${PWD}/terminal.sh" >> ~/.bashrc
	ln -sf ${PWD}/vimrc ~/.vimrc
	ln -sf ${PWD}/rustconfig ~/.cargo/config
	ln -sf ${PWD}/coc-settings.json	 ~/.vim/coc-settings.json
	cp -f ${PWD}/gitconfig ~/.gitconfig
}

function install_rust {
	# install rust
	curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh

	cargo install -f --git https://github.com/starship/starship
	cargo install ripgrep_all --locked
	cargo install ripgrep --features 'pcre2'
	cargo install --locked zellij
	./cargo.sh
}

function install_all {
	install_host
	install_fzf
	install_rust
	install_vim
	install_nvim
}

function install_nvim {
	git clone https://github.com/neovim/neovim.git --depth=1 --branch=stable
	pushd neovim/
	make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local/ -j${nproc}
	make install
	popd
	#conda install -c conda-forge neovim # pip3 install --user --upgrade neovim
}

function install_fzf {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/.fzf
	~/.local/.fzf/install --all
}

function install_vim {
	git clone https://github.com/vim/vim.git --depth=1
	pushd vim
	./configure --with-features=huge --enable-python3interp --enable-pythoninterp --prefix=$HOME/.local/ --enable-luainterp --enable-cscope --enable-multibyte
	make  -j${nproc}
	make install
	popd
	rm -rf vim
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
