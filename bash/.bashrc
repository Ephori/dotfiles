
# Basic 
# PS1='\[\e[32m\]\u\[\e[0m\]:\[\e[33m\]\w\[\e[0m\]\$ '

# Server
# PS1='\[\e[32m\]\u\[\e[0m\]@\[\e[34m\]$(hostname -i)\[\e[0m\]:\[\e[33m\]\w\[\e[0m\]\$ '

# Git Branch
parse_git_branch() {
    branch=$(git branch 2>/dev/null | grep '^\*' | sed 's/^\* //')
    if [ -n "$branch" ]; then
        echo " ($branch)"
    fi
}
PS1="\[\e[32m\]\u\[\e[0m\]@\[\e[34m\]\$(hostname -i)\[\e[0m\]:\[\e[33m\]\w\[\e[0m\]\[\e[36m\]\$(parse_git_branch)\[\e[0m\] \$ "

# Git
alias gs='git status'
alias gd='git diff'
gg() {
  git add .
  git commit
  git push
}

# History
shopt -s histappend
PROMPT_COMMAND="history -a; history -n"
HISTZIZE=10000
HISTFILESIZE=20000
