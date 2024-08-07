#!/bin/bash
# curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh

#export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
#export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

if ! command -v cargo >/dev/null ;then
	curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh | sh
fi

cat > ~/.cargo/config.toml << EOF
[source.crates-io]
replace-with = 'rsproxy-sparse'
[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"
[source.rsproxy-sparse]
registry = "sparse+https://rsproxy.cn/index/"
[registries.rsproxy]
index = "https://rsproxy.cn/crates.io-index"
[net]
git-fetch-with-cli = true
EOF

tools=(
	lsd
	starship
	mcfly
	bat
	#broot
	bottom
	cargo-update
	du-dust
	fd-find
	gitui # delta
	git-delta # delta
	#igrep
	#joshuto
	kmon # linux module
	#procs
	#peep
	ripgrep
	ripgrep_all
	mdcat
	#rm-improved
	tailspin # log tool
	topgrade
	tree-rs
	tealdeer # tldr
	vivid
	zenith
	zellij
	#xcp
)

# cargo install  ${tools[*]}
for tool in ${tools[@]}
do
	wtth_proxy cargo binstall --locked $tool
done

# curl --proto '=https' --tlsv1.2 -sSLf "https://git.io/JBhDb" | sh # install termscp
# cargo install --git  https://github.com/imsnif/bandwhich
# wget -O zjstatus.wasm https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm
mkdir ~/.config/zellij/plugins/
curl -L "https://github.com/rvcas/room/releases/latest/download/room.wasm" -o ~/.config/zellij/plugins/room.wasm
curl -L "https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" -o ~/.config/zellij/plugins/zjstatus.wasm

# from git install
# cargo install -f --git https://github.com/starship/starship
# cargo install ripgrep_all --locked
# cargo install --locked zellij
# cargo install ripgrep --features 'pcre2'
