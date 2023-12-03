#!/bin/bash
# curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh

#export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
#export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

tools=(
bat
#broot
bottom
cargo-update
du-dust
fd-find
igrep
joshuto
lsd
mcfly
#procs
#peep
ripgrep
ripgrep_all
mdcat
#rm-improved
starship
tree-rs
tealdeer # tldr
git-delta # delta
#xcp
)

cargo install  ${tools[*]}

# from git install
#cargo install -f --git https://github.com/starship/starship
#cargo install ripgrep_all --locked
#cargo install --locked zellij
