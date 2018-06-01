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

