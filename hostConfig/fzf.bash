# Setup fzf
if [[ ! "$PATH" == *fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.local/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.local/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.local/.fzf/shell/key-bindings.bash"
unset -f __fzf_history__

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

#if [[ ! "$PATH" == *$ConfigFolder/fzf/bin* ]]; then
#  PATH="${PATH:+${PATH}:}$ConfigFolder/fzf/bin"
#fi
#
## Auto-completion
## ---------------
#[[ $- == *i* ]] && source "$ConfigFolder/fzf/shell/completion.bash" 2> /dev/null

# add Supported commands
_fzf_setup_completion path code git z
_fzf_setup_completion dir tree

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

# for large git repo
export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || fd --type f --hidden --follow --strip-cwd-prefix --color=auto ${EXCLUDE_DIRS[@]} ) 2> /dev/null'

# fd
#export FZF_DEFAULT_COMMAND='(fd ${EXCLUDE_DIRS[@]}
#--hidden
#--type f
#--strip-cwd-prefix 
#--follow
#--color=auto
#) 2> /dev/null'

# ripgrep
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

FZF_CTRL_R_OPTS="--layout=reverse --preview 'echo {}' --preview-window down:3:hidden:wrap"
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude "${EXCLUDE_DIRS[@]}" . "$1"
}

## rga 
f() {
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
bind -m emacs-standard '"\C-x": " \C-b\C-k \C-u f \e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind -m vi-command '"\et": "\C-z\et\C-z"'
bind -m vi-insert '"\et": "\C-z\et\C-z"'


_fzf_compgen_path() {
  fd --hidden --follow ${EXCLUDE_DIRS[@]} . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow ${EXCLUDE_DIRS[@]} . "$1"
}

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
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

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

 rm -f /tmp/rg-fzf-{r,f}
 fgs() {
	 RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
	 INITIAL_QUERY="${*:-}"
	 : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
	     --bind "start:reload($RG_PREFIX {q})+unbind(ctrl-r)" \
	     --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
	     --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(→ )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
	     --bind "ctrl-r:unbind(ctrl-r)+change-prompt(rg> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
	     --color "hl:-1:underline,hl+:-1:underline:reverse" \
	     --prompt 'rg> ' \
	     --delimiter : \
	     --preview 'bat --color=always {1} --highlight-line {2}' \
	     --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
	     --bind 'enter:become(vim {1} +{2})'
 }

# ALT-t - rga open file
#bind -m emacs-standard '"\et": " \C-b\C-k \C-u`f`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
#bind -m emacs-standard '"\C-x": " \C-b\C-k \C-u`f`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
#bind -m vi-command '"\et": "\C-z\et\C-z"'
#bind -m vi-insert '"\et": "\C-z\et\C-z"'
