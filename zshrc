# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
 source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# User configuration
export PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Add paths
if [[ -d "/usr/local/go/bin" ]]; then
	export PATH=$PATH:"/usr/local/go/bin"
fi
if [[ -d "$HOME/local/flutter/bin" ]]; then
	export PATH=$PATH:"$HOME/local/flutter/bin"
fi
if [[ -d "$HOME/.config/composer/vendor/bin" ]]; then
	export PATH=$PATH:"$HOME/.config/composer/vendor/bin"
fi
if [[ -d "$HOME/.composer/vendor/bin" ]]; then
	export PATH=$PATH:"$HOME/.composer/vendor/bin"
fi
if [[ -d "$HOME/.gem/ruby/2.3.0/bin" ]]; then
	export PATH=$PATH:"$HOME/.gem/ruby/2.3.0/bin"
fi


# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Alias
alias gst="git status"
alias gdi="git diff"
alias gda="git branch -a"
alias gcm="git checkout master"

# 256 color terminal
export TERM="screen-256color"

# Virtualenvwrapper config
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# For the apt installtion of virtualenvwrapper
[ -f /etc/bash_completion.d/virtualenvwrapper ] && source /etc/bash_completion.d/virtualenvwrapper

# Source shellder theme
source ~/.dotfiles/zsh/shellder.zsh-theme

# DART OPTIONS
export PATH=$PATH:~/.pub-cache/bin

# GO OPTIONS
export GOPATH=$HOME/local/go
export PATH=$PATH:$GOPATH/bin

# Set ANDROID_HOME
if [[ -d "/opt/android-sdk" ]]; then
	export ANDROID_HOME="/opt/android-sdk"
fi
