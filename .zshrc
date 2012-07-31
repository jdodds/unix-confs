# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:editor' keymap 'emacs'

# Auto convert .... to ../..
zstyle ':omz:editor' dot-expansion 'no'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':omz:*:*' case-sensitive 'no'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':omz:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':omz:terminal' auto-title 'yes'

# Set the plugins to load (see $OMZ/plugins/).
zstyle ':omz:load' plugin 'archive' 'git'
zstyle ':omz:load' plugin 'archive' 'ssh-agent'

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':omz:prompt' theme 'steeef'

# This will make you shout: OH MY ZSHELL!
source "$HOME/workspace/oh-my-zsh/init.zsh"
source "$HOME/.rvm/scripts/rvm"

# Customize to your needs...

PATH="$HOME/bin:$HOME/.rvm/bin:/usr/share/java/apache-ant/bin:$HOME/.local/bin:$PATH"
EDITOR=emacs
