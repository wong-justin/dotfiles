# fun fact: to temporarily run a command with aliases disabled,
# prepend a backslash, eg: \grep
# note: this will not disable functions, only aliases
#
# ALIASING THE ALIAS
#
# use my alias alias pretty much the same as normal \alias, ie:
#   
#   `alias test "echo hello world"`
#
# then it will be immediately usable and also persisted in this .bash_aliases file
#
# IN MORE DETAIL
#
# it's partly taken from: https://unix.stackexchange.com/q/153977
# here is the un-minified approximation:
#
# function newalias {
# 	_name="$1"
# 	_command="${@:2}"
# 	if [ -z "$_name" ]; then
# 		echo "no alias given" >&2;
# 	else
# 		echo "\alias $_name='$_command'" >> ~/.bash_aliases
# 		source ~/.bash_aliases
# 	fi
# }
\alias alias='f(){ if [ -z "$1" ]; then echo "no alias given" >&2; else echo "\alias $1='\''"${@:2}"'\''" >> ~/.bash_aliases && source ~/.bash_aliases; fi; unset -f f; }; f'

# normal aliases below
\alias aliases='\alias'
\alias l='ls -CAp --color=never --group-directories'
\alias lss='ls -gGAh --group-directories-first --classify --color=never'
\alias vim='nvim'
\alias ..='cd ..'
\alias ~='cd ~'
\alias grep='grep --color=auto'
\alias fm='cd $(~/builds/fmin/target/debug/fmin)'
\alias clock='tput civis; watch -t -n1 ~/dotfiles/scripts/center_clock'
\alias screenshot='xwd -root | ffmpeg -i - ~/screenshots/$(date +"%FT%H%M").png'
# \alias firefox='firefox --profile ~/.config/firefox_profiles/me' # creates problems with symlinks, i think

# new aliases are added after this line
