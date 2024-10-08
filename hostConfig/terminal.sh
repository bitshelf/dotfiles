# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# command -v rg  >/dev/null 2>&1 &&  return

HOST_CONFIG=hostConfig

[ -r $HOME/.cargo/env ] && . "$HOME/.cargo/env"
export LANGUAGE=en_US
export LANG=en_US.UTF-8
shopt -s checkwinsize
shopt -s autocd
shopt -s cdspell

export HISTCONTROL=ignoreboth
# ignorespace: 忽略空格开头的命令
# ignoredups: 忽略连续重复命令
# ignoreboth: 表示上述两个参数都设置

# 设置追加而不是覆盖
shopt -s histappend

export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTIGNORE='pwd:exit:fg:bg:top:clear:history:ls:uptime:df'

# cargo
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

#CUR_PATH=`readlink -f "${BASH_SOURCE:-$0}"`
#export ConfigFolder=`dirname $CUR_PATH`
#CARGO_HOME=$ConfigFolder
#CARGO_INSTALL_ROOT=$ConfigFolder
#export PATH=$CARGO_HOME/.cargo/bin:$PATH
#export XDG_CONFIG_HOME=$(dirname "$CUR_PATH")

# essentials alias
alias ..='cd ..'
alias cp='cp -v'
alias ls='lsd'
# alias cat='bat'
alias vi='nvim'
alias tldr='tldr  -L zh'
#alias vim='nvim'
#alias cp='xcp'

alias l='ls -l'
alias la='ls -a'
alias ll='ls -la'
alias lt='ls --tree'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export LS_COLORS="$(vivid generate molokai)"

# prevent Ctrl-S from freezing the terminal to use the shortcut in vim.
# only in interactive shells
if [[ -n "$PS1" ]]; then
    bind -r '\C-s'
    stty -ixon
fi

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
[ -r /usr/share/bash-completion/completions/git ] && source  /usr/share/bash-completion/completions/git
#source $HOME/.local/lib/git-core/git-sh-prompt
[ -r ~/.config/${HOST_CONFIG}/rg.bash ] && source  ~/.config/${HOST_CONFIG}/rg.bash
[ -r ~/.config/${HOST_CONFIG}/fzf.bash ] && source  ~/.config/${HOST_CONFIG}/fzf.bash
[ -r ~/.config/${HOST_CONFIG}/chezmoi.bash ] && source  ~/.config/${HOST_CONFIG}/chezmoi.bash

# mcfly
eval "$(mcfly init bash)"
export MCFLY_RESULTS_SORT=LAST_RUN
export MCFLY_DISABLE_MENU=true
export MCFLY_PROMPT='→'
export MCFLY_HISTORY_LIMIT=10000
# export MCFLY_FUZZY=2
# export MCFLY_RESULTS=30

#readonly PROMPT_COMMAND

bind -r "\C-g"
bind -m emacs-standard -x '"\C-g": yazi '

# Completion settings
#source <(procs --gen-completion-out bash)

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/usr/bin:$PATH"
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Git config
if [ -f ~/.config/git/git-completion.bash ]; then
	source ~/.config/git/git-completion.bash
fi
export GIT_COMPLETION_SHOW_ALL_COMMANDS=1

# if ! hash nvm 2>/dev/null; then
# 	export NVM_DIR="$HOME/.local/.nvm"
# 	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# 	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# fi

# with_proxy(){
#    HTTPS_PROXY=socks5://localhost:7890 HTTP_PROXY=socks5://localhost:7890 "$@"
# }

rehash(){

	# export PATH="$HOME/.local/gettext/bin:$PATH"
	# export LD_LIBRARY_PATH="$HOME/.local/gettext/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH"
	# export LD_LIBRARY_PATH="$HOME/.local/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH"
	# export LD_LIBRARY_PATH="$HOME/.local/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH"

	# JDK
	# export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64/"
	# export PATH="$JAVA_HOME/bin:$PATH"
	# export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	if [ -d "$HOME/miniconda3/bin" ] ; then
		export PATH="$HOME/miniconda3//bin/:$PATH"
	fi
	__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
			. "$HOME/miniconda3/etc/profile.d/conda.sh"
		else
			export PATH="$HOME/miniconda3/bin:$PATH"
		fi
	fi
	unset __conda_setup
	# <<< conda initialize <<<
}
