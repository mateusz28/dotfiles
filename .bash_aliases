export PATH="/subversion_1.8/bin:$PATH"
export PATH="$PATH:/home/mateuszorzol/bin/lib:/home/mateuszorzol/bin/bin"
export PATH="$PATH:/home/mateuszorzol/bin"
export SVN_EDITOR='~/bin/vim/bin/vim -c "4,\$!cut -c-5 --complement | xargs svn diff --no-diff-deleted -x --ignore-eol-style" -c "set syntax=diff" +0'
export EDITOR=vim

alias vim='~/bin/vim/bin/vim'
alias vimdiff='~/bin/vim/bin/vimdiff'
alias cmake='~/bin/bin/cmake'
alias vifm='~/bin/bin/vifm'
