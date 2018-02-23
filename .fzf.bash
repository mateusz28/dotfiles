# Setup fzf
# ---------
if [[ ! "$PATH" == */home/matorz/.fzf/bin* ]]; then
  export PATH="$PATH:/home/matorz/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/matorz/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/matorz/.fzf/shell/key-bindings.bash"

fag(){
  local line
  line=`ag --nocolor "$1" | fzf` \
    && vim $(cut -d':' -f1 <<< "$line") +$(cut -d':' -f2 <<< "$line")
}
