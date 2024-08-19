#!/bin/bash

function install_host {
	touch $HOME/.hushlogin
	echo "source ${PWD}/terminal.sh" >> ~/.bashrc
	#ln -sf ${PWD}/vimrc ~/.vimrc
	# ln -sf ${PWD}/rustconfig ~/.cargo/config
	ln -sf ${PWD}/coc-settings.json	 ~/.vim/coc-settings.json
	echo "with_proxy(){
	   HTTPS_PROXY=socks5://localhost:7897 HTTP_PROXY=socks5://localhost:7897 \"\$@\"
	}" >> ~/.bashrc
	curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.config/git/git-completion.bash
}

function install_node {
	mkdir -p $HOME/.local/.nvm/
	# wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
	# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	export NVM_DIR="$HOME/.local/.nvm" && ( git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR";   cd "$NVM_DIR";   git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`; ) && \. "$NVM_DIR/nvm.sh"

	export NVM_DIR="$HOME/.local/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

	nvm install --lts

}

function install_rust {
	# install rust
	curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh
	. "$HOME/.cargo/env"

	cargo install cargo-binstall
	./cargo.sh
}

function install_nvim {
	git clone https://github.com/neovim/neovim.git --depth=1 --branch=stable
	# git clone https://github.com/neovim/neovim.git --depth=1
	pushd neovim/
	make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local/ -j${nproc}
	if [[ $? = 0 ]];then
		make install
	else
		exit 1
	fi

	popd
	rm -rf neovim
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

function install_yazi {
	cargo install -f --locked --git https://github.com/sxyazi/yazi.git yazi-fm yazi-cli
	ya pack -a Rolv-Apneseth/starship
	ya pack -a Lil-Dank/lazygit
	ya pack -a yazi-rs/plugins:no-status
	ya pack -a yazi-rs/plugins:max-preview
}

function install_lazygit {
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
	rm lazygit.tar.gz lazygit -rf
}

function install_all {
	install_host
	install_fzf
	install_rust
	install_vim
	install_nvim
	install_yazi
	install_lazygit
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
