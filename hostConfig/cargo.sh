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
	bottom
	cargo-update
	du-dust
	fd-find
	gitui # delta
	git-delta # delta
	kmon # linux module
	ripgrep
	ripgrep_all
	mdcat
	ouch
	tailspin # log tool
	topgrade
	tree-rs
	tealdeer # tldr
	vivid
	zellij
)

cargo install cargo-binstall

# cargo install  ${tools[*]}
for tool in ${tools[@]}
do
	#cargo install --locked $tool
	cargo binstall -y $tool
done

# curl --proto '=https' --tlsv1.2 -sSLf "https://git.io/JBhDb" | sh # install termscp
# wget -O zjstatus.wasm https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm
mkdir ~/.config/zellij/plugins/
curl -L "https://github.com/rvcas/room/releases/latest/download/room.wasm" -o ~/.config/zellij/plugins/room.wasm
curl -L "https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm" -o ~/.config/zellij/plugins/zjstatus.wasm

# other cargo install
cargo install --git https://github.com/bvaisvil/zenith.git
# cargo install --git  https://github.com/imsnif/bandwhich
