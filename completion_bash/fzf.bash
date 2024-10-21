# Setup fzf
if [[ ! "$PATH" == *fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.local/.fzf/bin"
fi

# bash integration
# eval "$(fzf --bash)"
FZF_ALT_C_COMMAND=  eval "$(fzf --bash)"


EXCLUDE_DIRS=(\
	-E tools \
	-E .git \
	-E out \
	-E sdk \
	-E cts \
	-E bionic \
	-E buildroot/output/ \
	-E development \
	-E .git \
	-E toolchain \
)

# for large git repo
export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || fd --type f --hidden --follow --strip-cwd-prefix --color=auto ${EXCLUDE_DIRS[@]} ) 2> /dev/null'

# FZF_DEFAULT_COMMAND only use fd
#export FZF_DEFAULT_COMMAND='(fd ${EXCLUDE_DIRS[@]}
#--hidden
#--type f
#--strip-cwd-prefix 
#--follow
#--color=auto
#) 2> /dev/null'

# FZF_DEFAULT_COMMAND only use ripgrep
#export FZF_DEFAULT_COMMAND="(rg --hidden --files --follow  -g '!{.git,tools,sdk,out,tools,cts,buildroot/output,development,toolchain}')2> /dev/null"

# preview
# --preview 'bat --color=always --style=header,grid --line-range :300 {}'
# --preview-window 'right:60%'
# --bind 'ctrl-space:toggle-preview'
# --ansi
export FZF_DEFAULT_OPTS="
--prompt='→ '
--pointer='→'
--marker='✗' 
--height 90% 
--border 
--margin=1 
--multi
--layout=reverse 
"

export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# remove fzf history key-binding
bind -r "\C-r"

# fzf history
# FZF_CTRL_R_OPTS="--layout=reverse --preview 'echo {}' --preview-window down:3:hidden:wrap"

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude "${EXCLUDE_DIRS[@]}" . "$1"
}

# add Supported commands
_fzf_setup_completion path code git z
_fzf_setup_completion dir tree

_fzf_compgen_path() {
  fd --hidden --follow ${EXCLUDE_DIRS[@]} . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow ${EXCLUDE_DIRS[@]} . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}


########################## custon function #########################
## rga 
ff() {
 RG_PREFIX="rga --files-with-matches"
 local FILES=(tar.gz gz zip)
 local file
 file="$(
  FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
   fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
    --phony -q "$1" \
    --bind "change:reload:$RG_PREFIX {q}" \
    --preview-window="60%:wrap"
 )" && \
    if [ !"$file" ]; then
	    [[ ${FILES[@]/${file##*.}/} != ${FILES[@]} ]] && echo "$file" || \
	    if [ "x$TERM_PROGRAM" = "xvscode" ]; then
		 echo "$file" && code "$file"
	    else	    
		 if [ ${file##*.} = pdf ]; then
			 echo "$file"
		 else
			echo "$file" && $EDITOR "${file}"
		 fi
	    fi
    fi
}

# key-binding <C-x> for rga
# bind -r "\C-x"
# bind -m emacs-standard '"\C-x": " \C-b\C-k \C-u`ff`\e\C-e\er\C-m\C-u\e \ey\C-d"'
# bind -m vi-command '"\C-x": "\C-z\C-x\C-z"'
# bind -m vi-insert '"\C-x": "\C-z\C-x\C-z"'


# dir
cdd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
				  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vi} "${files[@]}"
}

# key-binding <C-t> for fzf
# if (( BASH_VERSINFO[0] > 4 )); then
# 	bind -r "\C-t"
# 	if [[ "${FZF_CTRL_T_COMMAND-x}" != "" ]]; then
# 		bind -m emacs-standard -x '"\C-t": fe'
# 		bind -m vi-command -x '"\C-t": fe'
# 		bind -m vi-insert -x '"\C-t": fe'
# 	fi
# fi

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
rf() {
	rm -f /tmp/rg-fzf-{r,f}
	INITIAL_QUERY="${*:-}"
	: | fzf --ansi --disabled --query "$INITIAL_QUERY" \
		--bind "start:reload:$RG_PREFIX {q}" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--bind 'ctrl-t:transform:[[ ! $FZF_PROMPT =~ ripgrep ]] &&
		echo "rebind(change)+change-prompt(ripgrep> )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r" ||
		echo "unbind(change)+change-prompt(fzf> )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"' \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--prompt 'ripgrep> ' \
		--delimiter : \
		--header 'CTRL-T: Switch between ripgrep/fzf' \
		--preview 'bat --color=always {1} --highlight-line {2}' \
		--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
		--bind 'enter:become($EDITOR {1} +{2})'
}
