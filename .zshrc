# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

#cd ~/Spring16/JavaOOP/
#cd ~/android/Tetris/
cd ~/android/TTetris/src/dev/ttetris/
#cd ~/mit/mix/Undertable\ Blackmail
#cd ~/android/TTetris/src/dev/ttetris
#cd ~/android/Tetris/src/dev/tetris
#cd ~/android/TetrisLR/AndDoc
#cd ~/towerplayer/
#cd ~/android/DrawingFun/src/dev/drawingfun/
#cd ~/android/DorkyMonkey/src/dev/dorkymonkey/
#cd ~/AI/Connect4AI/
#cd /home/jenny/deepwaterooo.github.com/
#cd ~/RubyOnRails/gosu/
#cd ~/php/project/
#cd ~/AngularJS/lifelove/
#cd ~/cv/interview/
#cd ~/580/
#cd ~/480/qt/SeniorDesign/
#cd ~/480/Tower_creator/
#cd ~/LintCode/
#cd ~/lc/Java/

#alias "ie=ibus exit"
#alias "is=ibus-setup"
#/usr/bin/zsh ~/ibus_run.sh   # don't need this one anymore
/bin/bash ~/.middle-click.sh

alias e="emacs"
alias jc="javac "
alias j="java "
alias e="emacs"
alias g='g++'
alias a="./a.out"
alias ge="gedit"
alias "ec=~/installed/adt-bundle-linux-x86_64-20140702/eclipse/eclipse &"
alias "ecd=adb logcat -v long > log.txt"
alias "ee=emacs ~/.emacs &"
alias "eb=emacs ~/.bashrc &"
alias "ez=emacs ~/.zshrc &"
alias "eed=cd ~/.emacs.d"
alias "ej=cd ~/.emacs.d/elpa/yasnippet-0.8.0/snippets/java-mode/"
alias "edb=emacs --debug-init"
alias "mc=mpicc"
alias "mr=mpirun"
alias "h=cd ~"
alias cls='clear'
alias "qc=/opt/Qt/Tools/QtCreator/bin/qtcreator &"
#alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias llt="ls -lt"
alias up='cd ..'

alias ga="git add"
alias gs="git status"
alias z="gnome-terminal -geometry 75x45+1000+0"

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

autoload -U compinit
compinit

# For autocompletion of command line switches for aliases
setopt completealiases
setopt AUTO_LIST
setopt AUTO_MENU

# bindkey for emacs
bindkey -e

#自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'
 
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
 
#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'
 
#彩色补全菜单
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
 
#kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'
 
#补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'
 
# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
#}}}
 
##行编辑高亮模式 {{{
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域
special:bold      #特殊字符
isearch:underline)#搜索时使用的关键字
#}}}
 
##空行(光标在行首)补全 "cd " {{{
user-complete(){
case $BUFFER in
"" )                       # 空行填入 "cd "
BUFFER="cd "
zle end-of-line
zle expand-or-complete
;;
"cd --" )                  # "cd --" 替换为 "cd +"
BUFFER="cd +"
zle end-of-line
zle expand-or-complete
;;
"cd +-" )                  # "cd +-" 替换为 "cd -"
BUFFER="cd -"
zle end-of-line
zle expand-or-complete
;;
* )
zle expand-or-complete
;;
esac
}
zle -N user-complete
bindkey "\t" user-complete
#}}}
 
##在命令前插入 sudo {{{
#定义功能
sudo-command-line() {
[[ -z $BUFFER ]] && zle up-history
[[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
zle end-of-line                 #光标移动到行末
}
zle -N sudo-command-line
#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line
#}}}

#漂亮又实用的命令高亮界面
setopt extended_glob
TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')

recolor-cmd() {
    region_highlight=()
    colorize=true
    start_pos=0
    for arg in ${(z)BUFFER}; do
        ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
			((end_pos=$start_pos+${#arg}))
			if $colorize; then
			    colorize=false
			    res=$(LC_ALL=C builtin type $arg 2>/dev/null)
			    case $res in
				*'reserved word'*)   style="fg=magenta,bold";;
				*'alias for'*)       style="fg=cyan,bold";;
				*'shell builtin'*)   style="fg=yellow,bold";;
				*'shell function'*)  style='fg=green,bold';;
				*"$arg is"*)
				    [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
				*)                   style='none,bold';;
			    esac
			    region_highlight+=("$start_pos $end_pos $style")
			fi
			[[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
			start_pos=$end_pos
    done
		    }
		    check-cmd-self-insert() { zle .self-insert && recolor-cmd }
		    check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/opt/adt-bundle-linux-x86_64-20140702/sdk/platform-tools/:/home/jenny/installed/adt-bundle-linux-x86_64-20140702/sdk/tools:/home/jenny/installed/adt-bundle-linux-x86_64-20140702/sdk/platform-tools:/usr/lib/jvm/java-1.6.0-openjdk-amd64/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# for android sdk
#export PATH=/home/jenny/installed/adt-bundle-linux-x86_64-20140702/sdk/platform-tools/:$PATH

# followed this link
# http://tutorialforlinux.com/2013/11/26/how-to-install-android-sdk-tools-only-on-linux-mint-16-petra-easy-guide/
export PATH=/opt/adt-bundle-linux-x86_64-20140702/sdk/platform-tools/:$PATH


x-copy-region-as-kill () {
  zle copy-region-as-kill
#  print -rn $CUTBUFFER | xsel -i
  print -rn $CUTBUFFER | xclip -i -selection clipboard
}
zle -N x-copy-region-as-kill

copy-region-as-kill-deactivate-mark () {
#  zle copy-region-as-kill
  zle x-copy-region-as-kill
  zle set-mark-command -n -1
}
zle -N copy-region-as-kill-deactivate-mark

x-kill-region () {
  zle kill-region
#  print -rn $CUTBUFFER | xsel -i
  print -rn $CUTBUFFER | xclip -i -selection clipboard
}
zle -N x-kill-region

x-yank () {
  CUTBUFFER=$(xclip -o)
#  CUTBUFFER=`echo -n $CLIP`
#  CUTBUFFER=$(xclip -d)
  zle yank
}
zle -N x-yank

bindkey -e '^v' set-mark-command
#bindkey -e '\eW' x-copy-region-as-kill
#bindkey -e '^[w' x-copy-region-as-kill
bindkey '^[w' copy-region-as-kill-deactivate-mark
bindkey -e '^w' x-kill-region
bindkey -e '^y' x-yank

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word　＃复制前一行命令最后一个word

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PROMPT_COMMAND="history -a"

export PATH="$PATH:/usr/bin/"
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/"

# for hadoop
#export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_25/
#export PATH=$PATH:$JAVA_HOME/bin/
#export JUNIT_HOME=/usr/lib/jvm/jdk1.8.0_25/jre/lib/

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
export PATH=$JAVA_HOME/bin/:$PATH
#export JUNIT_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/
#export CLASSPATH=$CLASSPATH:$JUNIT_HOME/junit-4.12.jar:.
#export CLASSPATH=$CLASSPATH:$JUNIT_HOME/hamcrest-core-1.3.jar:.
#export CLASSPATH=$CLASSPATH:/usr/share/java/vecmath.jar:.

#export HADOOP_HOME=/usr/local/hadoop
#JAVA_HOME=/etc/alternative/jre

# Some convenient aliases and functions for running Hadoop-related commands
unalias fs &> /dev/null
alias fs="hadoop fs"
unalias hls &> /dev/null
alias hls="fs -ls"

# If you have LZO compression enabled in your Hadoop cluster and
# compress job outputs with LZOP (not covered in this tutorial):
# Conveniently inspect an LZOP compressed file from the command
# line; run via:
#
# $ lzohead /hdfs/path/to/lzop/compressed/file.lzo
#
# Requires installed 'lzop' command.
#
lzohead () {
        hadoop fs -cat $1 | lzop -dc | head -1000 | less
}

# Add Hadoop bin/ directory to PATH
export PATH=$PATH:$HADOOP_HOME/bin
source ~/.nvm/nvm.sh

# for Ruby
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting  
source ~/.bash_profile  
