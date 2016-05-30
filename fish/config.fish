set fisher_home ~/.config/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/fisher.fish

set -x EDITOR vim

# Remove the greeting message
set fish_greeting

# Paths
test -d /usr/local/go/bin ; and set PATH /usr/local/go/bin $PATH
test -d ~/.config/composer/vendor/bin ; and set PATH ~/.config/composer/vendor/bin $PATH

# Tmux alias to fix color issue
alias tmux "tmux -2"

# Some git alias
alias gst "git status"
alias gdi "git diff"
alias gba "git branch -a"
alias gcm "git checkout master"
alias gcb "git checkout -b"
alias gco "git checkout"
alias grb "git rebase"
alias grba "git rebase --abort"
alias grbc "git rebase --continue"
alias grbi "git rebase -i"
alias grbm "git rebase master"

# Set shellder config
set -g theme_display_user yes
set -g theme_hostname always

# Set nvim alias
if type nvim >/dev/null
    alias vim "nvim"
end

# Set GOPATH
if type go >/dev/null
  set -x GOPATH ~/local/go
  mkdir -p $GOPATH
  if test -d $GOPATH/bin
    set PATH $PATH $GOPATH/bin
  end
end

# Set DARTPATH
if type dart >/dev/null
  set -x DARTPATH ~/.pub-cache/
  mkdir -p $DARTPATH
  if test -d $DARTPATH/bin
    set PATH $PATH $DARTPATH/bin
  end
end

# Set ANDROID_HOME
if test -d /opt/android-sdk
  set ANDROID_HOME /opt/android-sdk
end
