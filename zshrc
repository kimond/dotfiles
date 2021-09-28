# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
 source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# pyenv
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"


# User configuration
export PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Add paths
if [[ -d "$HOME/bin" ]]; then
	export PATH=$PATH:"$HOME/bin"
fi
if [[ -d "$HOME/.local/bin" ]]; then
	export PATH=$PATH:"$HOME/.local/bin"
fi
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
if [[ -d "$HOME/.poetry/bin" ]]; then
	export PATH=$PATH:"$HOME/.poetry/bin"
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

if [ $commands[kubectl] ]; then
      source <(kubectl completion zsh)
fi

# Import colorscheme from wal
ps -o 'command=' -p $(ps -o 'ppid=' -p $$) | grep -v 'idea' &> /dev/null
if [ $? -eq 0 ]; then
	if [[ -f ~/.cache/wal/sequences ]]; then
		(cat ~/.cache/wal/sequences &)
	fi
	if [[ -f ~/.cache/wal/colors-tty.sh ]]; then
		source ~/.cache/wal/colors-tty.sh
	fi
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP


export PATH=/Users/kdesrosiers/.local/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kdesrosiers/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kdesrosiers/.local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kdesrosiers/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kdesrosiers/.local/google-cloud-sdk/completion.zsh.inc'; fi

# TEMP I GUESS
export PATH="/usr/local/opt/node@14/bin:$PATH"
