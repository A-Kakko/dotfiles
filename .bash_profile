#
# ~/.bash_profile
#

# Load uwsm environment variables
[[ -f ~/.config/uwsm/env ]] && source ~/.config/uwsm/env

[[ -f ~/.bashrc ]] && . ~/.bashrc

. "$HOME/.local/share/../bin/env"
