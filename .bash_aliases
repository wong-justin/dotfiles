# note: new aliases are concatenated at the bottom of the file
#
# fun fact: to temporarily run a command with aliases disabled,
# prepend a backslash, eg: \grep
# note: this will not disable functions, only aliases
#
# ALIASING THE ALIAS
#
# use my alias alias pretty much the same as normal \alias, ie:
#   
#   `alias test 'echo hello world'`
#
# then it will be immediately usable and also persisted in this .bash_aliases file
#
# IN MORE DETAIL
#
# it's partly taken from: https://unix.stackexchange.com/q/153977
# here is the un-minified approximation:
#
# function newalias {
# 	echo "\alias $1='${@:2}'" >> ~/.bash_aliases
# 	source ~/.bash_aliases
# }
#
# or longer, and not just the happy path:
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
\alias aliases='nvim ~/.bash_aliases -c '\''normal G'\''; source ~/.bash_aliases'
  # or maybe aliases='source ~/.bash_aliases; \alias'
\alias l='ls -CAp --color=never --group-directories-first'
\alias lss='ls -gGAh --group-directories-first --classify --color=never'
\alias vim='nvim'
\alias ..='cd ..'
\alias ~='cd ~'
\alias grep='grep --color=auto'
\alias fm='cd $(~/builds/fmin/target/release/fmin)'
\alias clock='tput civis; watch -t -n1 ~/dotfiles/scripts/center_clock'
\alias screenshot='xwd -root | ffmpeg -i - ~/screenshots/$(date +"%FT%H%M").png'
# \alias firefox='firefox --profile ~/.config/firefox_profiles/me' # creates problems with symlinks, i think
\alias slippi='slippi-launcher &'
\alias joke='curl https://icanhazdadjoke.com && echo'
\alias cx='chmod +x'
\alias vic='/home/wonger/builds/vic/target/release/vic'
\alias oops='$(fc -ln -2 -2 | sed '\''s/^/sudo /g'\'')'
  # this is basically oops='sudo !!'
\alias rm='rm -I'
\alias fd='fd -c never'
\alias find='fd'
\alias clip='xclip -selection clipboard'
\alias unclip='xclip -selection clipboard -o'
\alias prose='/home/wonger/builds/writenow/writenow -o ~/prose/$(date +%Y-%m-%d).txt; echo >> ~/prose/$(date +%Y-%m-%d).txt'
\alias today='date +%Y-%m-%d'
\alias setvol='wpctl set-volume @DEFAULT_AUDIO_SINK@'
\alias getvol='wpctl get-volume @DEFAULT_AUDIO_SINK@'
\alias nugget='P="/home/wonger/wonger.dev/dist/nuggets.html";N=$(( $(cat "$P" | htmlq ".card" --attribute id | sed "s/n//" | sort -n | tail -1) + 1)); echo $N; cat "$P" | htmlq ".card:first-of-type" -r '\''.card > *:not(.bottom-line)'\'' | sed '\''s/datetime=".*"/datetime="'\''"$(date +%Y-%m-%d)"'\''"/'\'' | sed -E '\''s/(n|#)[0-9]+/\1'\''$N'\''/'\'' | clip; vim "$P" -c "/class=\"card" -c "normal O" -c "r !xclip -selection clipboard -o" -c "normal 2o" -c "normal 7ki<p>TODO: new nugget</p>" -c "normal 0w" -c "let @/ = \"\""'
  # aka
  #
  # N=$(( $(cat nuggets.html | htmlq ".card" --attribute id | sed "s/n//" | sort -n | tail -1) + 1)); cat nuggets.html | htmlq ".card:first-of-type" -r '.card > *:not(.bottom-line)' | sed 's/datetime=".*"/datetime="'"$(date +%Y-%m-%d)"'"/' | sed -E 's/(n|#)[0-9]+/\1'$N'/' | clip; vim nuggets.html -c "/class=\"card" -c 'normal O' -c 'r !xclip -selection clipboard -o' -c 'normal 2o' -c "normal 7k"
  #
  # aka
  #
  # P=~/wonger.dev/dist/nuggets.html;
  # and
  # N=$(( $(cat $P | htmlq ".card" --attribute id | sed "s/n//" | sort -n | tail -1) + 1)); 
  # and
  # cat $P | htmlq ".card:first-of-type" -r '.card > *:not(.bottom-line)' | sed 's/datetime=".*"/datetime="'"$(date +%Y-%m-%d)"'"/' | sed -E 's/(n|#)[0-9]+/\1'$N'/' | clip;
  # then
  # vim $P -c "/class=\"card" -c "normal O" -c "r !xclip -selection clipboard -o" -c "normal 2o" -c "normal 7ki<p>TODO: new nugget</p>" -c "normal 0w" -c "let @/ = \"\""'
  #
  # I should make a lil blog post breakdown for this... sharing about escaping quotes, shell expansions (when they happen or not), vim -c startup option and command format, htmlq tool, sed regex... all for a microblogging shortcut within plain html
