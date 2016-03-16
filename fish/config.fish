set fisher_home ~/.config/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish

set -x EDITOR vim

# Remove the greeting message
set fish_greeting

# Paths
test -d /usr/local/go/bin ; and set PATH /usr/local/go/bin $PATH

# Some git alias
alias gst "git status"
alias gdi "git diff"
alias gba "git branch -a"
alias gcm "git checkout master"

# Set shellder config
set -g theme_display_user yes
set -g theme_hostname always

# Set GOPATH
if type go >/dev/null
  set -x GOPATH ~/local/go
  mkdir -p $GOPATH
  if test -d $GOPATH/bin
    set PATH $PATH $GOPATH/bin
  end
end
