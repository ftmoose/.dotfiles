#zmodload zsh/zprof

# prompt
PROMPT='%n %B%.%b 🤟 '

alias lsa='ls -alh'
alias ls='exa'
alias python=python3
alias vim=nvim
alias cd='z'
alias clear='clear && pwd && ls && echo && git status'

export NVM_DIR="$HOME/.nvm"

# This was taking a very long time so I cut it out.. 
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOBIN=/usr/local/go/bin
export PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/bin:$GOBIN
export PATH=$PATH:/Users/moose/bin

# lazy load nvm
lazy_load_nvm() {
	unset -f npm node nvm
	export NVM_DIR=~/.nvm
	[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

npm() {
	lazy_load_nvm
	npm $@
}

node() {
	lazy_load_nvm
	node $@
}

nvm () {
	lazy_load_nvm
	nvm $@
}
#

source /Users/moose/zsh-z/zsh-z.plugin.zsh

#zprof
alias dotfiles='git --git-dir=/Users/moose/.dotfiles.git --work-tree=/Users/moose'
