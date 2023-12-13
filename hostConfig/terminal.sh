HOST_CONFIG=hostConfig

. "$HOME/.cargo/env"
export LANGUAGE=en_US
export LANG=en_US.UTF-8

# cargo  
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

#CUR_PATH=`readlink -f "${BASH_SOURCE:-$0}"`
#export ConfigFolder=`dirname $CUR_PATH`
#CARGO_HOME=$ConfigFolder
#CARGO_INSTALL_ROOT=$ConfigFolder
#export PATH=$CARGO_HOME/.cargo/bin:$PATH
#export XDG_CONFIG_HOME=$(dirname "$CUR_PATH")

# alias
alias ls='lsd'
alias cat='bat'
alias vi='nvim'
#alias vim='nvim'
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

export EDITOR=nvim
if [ "x$TERM_PROGRAM" = "xvscode" ]; then
        export EDITOR=code
fi



# prompt settings
eval "$(starship init bash)"
#eval "$(zoxide init bash)"

# delta
export DELTA_FEATURES=+side-by-side

# difft
export DFT_DISPLAY=side-by-side-show-both


# system PATH
source  /usr/share/bash-completion/completions/git
#source $HOME/.local/lib/git-core/git-sh-prompt
source  ~/.config/${HOST_CONFIG}/rg.bash
source  ~/.config/${HOST_CONFIG}/fzf.bash

# mcfly
eval "$(mcfly init bash)"
export MCFLY_FUZZY=2
export MCFLY_RESULTS_SORT=LAST_RUN
export MCFLY_HISTORY_LIMIT=10000
export MCFLY_RESULTS=30
export MCFLY_DISABLE_MENU=true
export MCFLY_PROMPT='→'
#readonly PROMPT_COMMAND

# Completion settings
#source <(procs --gen-completion-out bash)

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/usr/bin:$PATH"
    PATH="$HOME/.local/bin:$PATH"
	export LD_LIBRARY_PATH="$HOME/.local/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH"
fi

if [ -d "$HOME/miniconda3/bin" ] ; then
	export PATH="$HOME/miniconda3//bin/:$PATH"
fi
#export PATH="$HOME/.local/gettext/bin:$PATH"
#export LD_LIBRARY_PATH="$HOME/.local/gettext/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH"
#export LD_LIBRARY_PATH="$HOME/.local/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH"

# JDK
export JAVA_HOME="$HOME/.local/jdk-17.0.7+7"
export PATH="$JAVA_HOME/bin:$PATH"
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

if [ -f ~/.config/git-completion.bash ]; then
	source ~/.config/git-completion.bash
fi

with_proxy(){
   HTTPS_PROXY=socks5://192.168.0.36:7890 HTTP_PROXY=socks5://192.168.0.36:7890 "$@"
}
