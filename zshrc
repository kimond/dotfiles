# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
 source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# User configuration
export PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Add paths
if [[ -d "$HOME/.dotfiles/bin" ]]; then
	export PATH=$PATH:"$HOME/.dotfiles/bin"
fi
if [[ -d "/usr/local/go/bin" ]]; then
	export PATH=$PATH:"/usr/local/go/bin"
fi
if [[ -d "$HOME/development/flutter/bin" ]]; then
	export PATH=$PATH:"$HOME/development/flutter/bin"
fi
if [[ -d "$HOME/.config/composer/vendor/bin" ]]; then
	export PATH=$PATH:"$HOME/.config/composer/vendor/bin"
fi
if [[ -d "$HOME/.composer/vendor/bin" ]]; then
	export PATH=$PATH:"$HOME/.composer/vendor/bin"
fi
if [[ -d "$HOME/.cargo/bin" ]]; then
	export PATH=$PATH:"$HOME/.cargo/bin"
fi
if [[ -d "$HOME/.yarn/bin" ]]; then
	export PATH=$PATH:"$HOME/.yarn/bin"
fi
if [[ -d "$HOME/.gem/ruby/2.3.0/bin" ]]; then
	export PATH=$PATH:"$HOME/.gem/ruby/2.3.0/bin"
fi
if [[ -d "$HOME/.anaconda3" ]]; then
    export PATH=$PATH:"$HOME/.anaconda3/bin"
fi

# Cuda
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/cuda/lib64"
export CUDA_HOME=/opt/cuda/


# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Alias
alias gst="git status"
alias gdi="git diff"
alias gda="git branch -a"
alias gcm="git checkout master"
alias dkc="docker-compose"

# 256 color terminal
export TERM="screen-256color"

# Virtualenvwrapper config
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# pyenv
export PATH="/home/kdesrosiers/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/local/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/local/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/local/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/local/google-cloud-sdk/completion.zsh.inc"; fi
