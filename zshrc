##### Autoload
autoload -U colors && colors
autoload -U compinit && compinit

##### Options
setopt nobeep
setopt ignoreeof
setopt autocd
setopt autopushd
setopt pushdignoredups
setopt correct
setopt prompt_subst

##### Prompt
prompt_base="----- %B%{$fg[white]%}%D{[%r] [%a %e %b %Y]}%(?.%{$fg_no_bold[green]%} [%?].%{$fg_bold[red]%} [%?])\$command_time_label%{$reset_color%}%b

===== %B%{$fg[blue]%}%n%{$fg[white]%}@%{$fg[yellow]%}%m%{$fg[white]%}:%b%{$fg[white]%}%U%d%u"

if [[ $(print -P "%#") == '#' ]] ; then
  prompt_user_character='#'
else
  prompt_user_character='$'
fi

export PS1="$prompt_base
%b%{$fg[white]%}$prompt_user_character %{$reset_color%}"

export RPS1="%{$fg_bold[white]%}%D{[%r] [%a %e %b %Y]}%{$reset_color%}%b"

set_command_time()
{
  if [[ -z "$command_start_time" ]] ; then
    command_time=
    return
  fi
  command_time=$(($SECONDS - $command_start_time))
  command_start_time=
  if [[ $command_time < 2 ]] ; then
    command_time=
    return
  fi
  ((command_time_seconds=command_time % 60, command_time/=60,
    command_time_minutes=command_time % 60, command_time/=60,
    command_time_hours=command_time % 24, command_time/=24,
    command_time_days=command_time))

  command_time=
  if [[ $command_time_days -gt 0 ]] ; then
    command_time="$command_time${command_time_days}d"
  fi
  if [[ $command_time_hours -gt 0 ]] ; then
    if [[ ! -z "$command_time" ]] ; then
      command_time="$command_time "
    fi
    command_time="$command_time${command_time_hours}h"
  fi
  if [[ $command_time_minutes -gt 0 ]] ; then
    if [[ ! -z "$command_time" ]] ; then
      command_time="$command_time "
    fi
    command_time="$command_time${command_time_minutes}m"
  fi
  if [[ $command_time_seconds -gt 0 ]] ; then
    if [[ ! -z "$command_time" ]] ; then
      command_time="$command_time "
    fi
    command_time="$command_time${command_time_seconds}s"
  fi
}

##### Window title
export TITLE_DIRECTORY_MAX_LENGTH=30

set_window_title()
{
  if [[ $1 != "" ]] ; then
    cmd=" -- $1"
  else
    cmd=""
  fi
  dir=`pwd | sed "s:${HOME}:~:"`
  if [[ ${#dir} -gt $(($TITLE_DIRECTORY_MAX_LENGTH - 3)) ]] ; then
    dir="...${dir:0,3-$TITLE_DIRECTORY_MAX_LENGTH}"
  fi
  echo -n -e \\033]0\;$TITLE_LABEL`hostname -s`:$dir $cmd\\007;
}

title() { export TITLE_LABEL="$* #" }
rtitle() { export TITLE_LABEL="$USER@" }
precmd()
{
  set_window_title;
  set_command_time;
  if [[ ! -z "$command_time" ]] ; then
    command_time_label="%{$fg_bold[white]%} [~${command_time}]"
  else
    command_time_label=
  fi
}
preexec()
{
  set_window_title $1
  command_start_time=$SECONDS
}

rtitle
preexec

##### Custom Commands
rcd () { cd $*; dirs -c; }
extensions () { find $1 -type f -name '*.*' | sed 's|.*\.||' | sort -u }
drop_spaces () { find . -name "*.$1" -type f -print0 | xargs -0 sed -i '' -e 's/[[:space:]]*$//' }

##### Aliases
alias proxy='title "seleucus (proxy)"; ssh degrendel.com -D 8080; title "**proxy closed**"'
alias mktags='ctags --langmap=php:+.inc --exclude=design --fields=+S -R *'
alias mktagsv='ctags --langmap=php:+.inc --exclude=design --fields=+S -V -R *'
alias ls='ls -h --color=auto'
alias screen='screen -T xterm'
alias update='sudo aptitude update && sudo aptitude -y full-upgrade'
alias grep='grep --color=auto'

##### Key bindings
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^?' backward-delete-char
bindkey "^P" vi-up-line-or-history
bindkey "^N" vi-down-line-or-history

bindkey "\e[1~" vi-beginning-of-line  # Home Linux console
bindkey "\e[H"  vi-beginning-of-line  # Home xterm
bindkey "\eOH"  vi-beginning-of-line  # Home gnome-terminal
bindkey "\e[4~" vi-end-of-line        # End Linux console
bindkey "\e[F"  vi-end-of-line        # End xterm
bindkey "\eOF"  vi-end-of-line        # End gnome-terminal

##### Global Environment
export EDITOR=vim
export CVS_RSH=/usr/bin/ssh
export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:"
export PATH=$PATH:$HOME/bin

##### Local Environment
if [[ -f ~/.zlocal ]] ; then
  source ~/.zlocal
fi
