# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '
# https://unix.stackexchange.com/a/26860
PROMPT_COMMAND='PS1X=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf -- "${q:1}")'
PS1='${PS1X}> '

# taken from: https://stackoverflow.com/a/19533853
# store more command history
# default of 500 is way too little
export HISTFILESIZE=
export HISTSIZE=
# and some sessions will truncate bash history anyways, so use different file
export HISTFILE=~/.bash_eternal_history

# set useful env vars for a variety of tools
export EDITOR=nvim

# pager preferences
# https://gist.github.com/jftuga/c31f00915863b463cf1ca16330876061
# -j.5 means center target line in middle of screen
LESS=-RIj.5

# TODO: clean up bash history by ignoring commands like `ls` 
# by adding it to the HISTIGNORE env var

# TODO: set vi keybinds instead of emacs things like C-w





# --- ALIASES --- #

# note: new aliases are concatenated at the bottom of the file
#
# fun fact: to temporarily run a command with aliases disabled,
# prepend a backslash, eg: \grep
# note: this will not disable functions, only aliases
#
# ALIASING THE ALIAS
#
# use my alias alias the same as normal \alias, ie:
#   
#   `alias test='echo hello world'`
#
# then it will be immediately usable and also persisted in this .bashrc file
# it's partly taken from: https://unix.stackexchange.com/q/153977
#
# checks that $1 matches format name=command
# and appends \alias name='command' to .bashrc

\alias alias='f(){
  _name="${1%%=*}"
  _command="${1#*=}"
  _quoted_command="${_command@Q}"
  if [ -z "$_name" ] || [ -z "$_command" ] || [ "$_name" == "$_command" ]; then
    echo "incorrect format... use alias name='\''command'\''" >&2
  else
    echo "\\alias $_name=$_quoted_command" >> ~/.bashrc && source ~/.bashrc
  fi;
  unset -f f
}; f'
  # note that name == command happens when no equal sign is present
  # this actually fails on certain cases: echo "\\alias $_name='\''"$_command"'\''" >> ~/.bashrc && source ~/.bashrc
\alias aliases='vim ~/.bashrc -c "normal G"; source ~/.bashrc'
  # or maybe aliases='source ~/.bashrc; \alias'

\alias l='ls -CAp --color=never --group-directories-first'
\alias lss='ls -gGAh --group-directories-first --classify --color=never'
\alias vim='nvim'
\alias ..='cd ..'
\alias ~='cd ~'
\alias grep='grep --color=auto'
\alias fm='cd $(~/builds/fmin/target/release/fmin)'
\alias clock='tput civis; watch -t -n1 ~/dotfiles/scripts/center_clock'
\alias screenshot='xwd -root | ffmpeg -i - ~/screenshots/$(date +"%FT%H%M").png'
  # TODO: copy to screenshot clipboard... image data esp, but also maybe path
# \alias firefox='firefox --profile ~/.config/firefox_profiles/me' # creates problems with symlinks, i think
\alias slippi='slippi-launcher &'
\alias joke='curl https://icanhazdadjoke.com; echo'
\alias cx='chmod +x'
\alias vic='~/builds/vic/target/release/vic'
\alias oops='$(fc -ln -2 -2 | sed '\''s/^/sudo /g'\'')'
  # this is basically oops='sudo !!'
\alias rm='rm -I'
\alias fd='fd -c never'
\alias find='fd'
\alias clip='xclip -selection clipboard'
\alias unclip='xclip -selection clipboard -o'
\alias prose='~/builds/writenow/writenow -o ~/prose/$(date +%Y-%m-%d).txt; echo >> ~/prose/$(date +%Y-%m-%d).txt'
\alias today='date +%Y-%m-%d'
\alias setvol='wpctl set-volume @DEFAULT_AUDIO_SINK@'
\alias getvol='wpctl get-volume @DEFAULT_AUDIO_SINK@'
# \alias nug="nuggets_path=~/wonger.dev/dist/nuggets.html;"'export new_nugget=$(cat $nuggets_path | htmlq .card:first-of-type -r '\''.card > *:not(.bottom-line)'\'' | sed '\''s/datetime=".*"/datetime="'\''$(date +%Y-%m-%d)'\''"/'\'' | perl -pe '\''s/(#|n)([0-9]+)/$1.($2+1)/e'\'' ); vim $nuggets_path -c /class=\"card -c "let @/ = \"\"" -c "normal O" -c "r !echo \"\$new_nugget\"" -c "normal 2o" -c "normal 6ki<p></p>" -c "normal 02f<" -c startinsert'
\alias nug='nuggets_path=$HOME/wonger.dev/dist/nuggets.html;(
export new_nugget="$(
  cat $nuggets_path | 
    htmlq .card:first-of-type -r '\''.card > *:not(.bottom-line)'\'' | 
    sed '\''s/datetime=".*"/datetime="'\''$(date +%Y-%m-%d)'\''"/'\'' | 
    perl -pe '\''s/(#|n)([0-9]+)/$1.($2+1)/e'\'' 
)"
vim $nuggets_path \
  -c /class=\"card \
  -c "let @/ = \"\"" \
  -c "normal O" \
  -c "r !echo \"\$new_nugget\"" \
  -c "normal 2o" \
  -c "normal 6ki<p></p>" \
  -c "normal ^f<" \
  -c startinsert
)'
# \alias please or howto=something like 'llm what is the shell command for $1'
\alias llm='f(){ llama-cli --hf-repo ggml-org/Qwen2.5-Coder-3B-Q8_0-GGUF --hf-file qwen2.5-coder-3b-q8_0.gguf -p "$1" 2>/dev/null; unset -f f; }; f'
\alias chat='llama-cli --hf-repo ggml-org/Qwen2.5-Coder-3B-Q8_0-GGUF --hf-file qwen2.5-coder-3b-q8_0.gguf --conversation -p "Make responses short. Only include necessary information." --no-display-prompt 2>/dev/null'
  # results as of Feb 2025: this local model is utterly slow and useless
\alias bws="~/dotfiles/scripts/bws"
\alias fetch='neofetch'
\alias expansion_test="echo '~';"'echo ~;'"echo ~;"'echo '\''$(echo ~);'\'
\alias date1="echo $(date)" # bad
\alias date2='echo $(date)' # good
\alias date3="echo \$(date)" # good
\alias repeat='f(){ for arg in "$@"; do echo "$arg"; done; unset -f f; }; f'
\alias multiline_test='(
echo hello \
world
echo goodbye
);'
\alias another_multiline_test="
echo hello world;

echo goodbye
"
\alias weird_test='echo start
echo end'
  # a mystery...
  # it outputs different garbage every time:
  #
  # start
  # Q�aސdend
  # 0x51, 0xfffd, 0x61, 0x790, 0x64 end
  # 
  # start
  # vend
  # 0x76 end
  # 
  # start
  # o�gQjUend
  # 0x6f, 0xfffd, 0x67, 0x51, 0x6a, 0x55 end
  #
  # - ofc the fix is to escape the newline with echo start; \
  # - one workaround is to run bash inside bash, 
  # where the alias works as expected (outputs start\nend)
  # - happens in ghostty terminal emulator, but not alacritty as far as i can tell
  # - weird
\alias getbrightness='ddcutil getvcp 10'
\alias setbrightness='f(){ ddcutil setvcp 10 "$1"; unset -f f; }; f'
