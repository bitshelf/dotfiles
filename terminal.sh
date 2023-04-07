
. "$HOME/.cargo/env"
export LANGUAGE=en_US
export LANG=en_US.UTF-8

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source ~/.config/fzf-git.sh

# cargo  
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
#CARGO_HOME=$ConfigFolder
#CARGO_INSTALL_ROOT=$ConfigFolder
#export PATH=$CARGO_HOME/.cargo/bin:$PATH
#export XDG_CONFIG_HOME=$(dirname "$CUR_PATH")

# alias
alias ls='lsd'
alias cat='bat'
#alias cp='xcp'

alias l='ls -l'
alias la='ls -a'
alias ll='ls -la'
alias lt='ls --tree'

#
# broot
#source /home/rpdzkj/.config/broot/launcher/bash/br

# starship
export STARSHIP_LOG=error

export EDITOR=vim
if [ "x$TERM_PROGRAM" = "xvscode" ]; then
        export EDITOR=code
fi



# prompt settings
eval "$(starship init bash)"
#eval "$(zoxide init bash)"
# mcfly
#export MCFLY_HISTORY="$ConfigFolder/.bash_history"
eval "$(mcfly init bash)"
export MCFLY_FUZZY=2
export MCFLY_RESULTS_SORT=LAST_RUN
export MCFLY_HISTORY_LIMIT=10000
export MCFLY_KEY_SCHEME=vim
export MCFLY_RESULTS=30
export MCFLY_DISABLE_MENU=true
export MCFLY_PROMPT='→'
#readonly PROMPT_COMMAND

# delta
export DELTA_FEATURES=+side-by-side

# difft
export DFT_DISPLAY=side-by-side-show-both


# system PATH
source  /usr/share/bash-completion/completions/git
source  ~/.config/rg.bash
source  ~/.config/fzf.bash

# Completion settings
source <(procs --gen-completion-out bash)

export PATH="$HOME/.config/bin/:$PATH"
export PATH="$HOME/.vscode-server/data/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/15.0.6/clangd_15.0.6/bin/:$PATH"
if [ -f ~/.config/git-completion.bash ]; then
	source ~/.config/git-completion.bash
fi
