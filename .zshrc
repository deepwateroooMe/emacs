export ZSH=$HOME/.oh-my-zsh
export PATH="/Users/qunyan/Library/Android/sdk/platform-tools":$PATH
export PATH="/Applications/Unity/Unity.app/Contents/MacOS":$PATH

cd /Volumes/h/leetcodeCoding

# bindkey for emacs
bindkey -e
#bindkey '^[[1;9C' forward-word
#bindkey '^[[1;9D' backward-word

bindkey '^[[1;ƒ' forward-word
bindkey '^[[1;∫' backward-word

# change volumens directories
alias vd="cl /Volumes/d"
alias ve="cl /Volumes/e/androidTests"
alias vf="cl /Volumes/f"
alias vg="cl /Volumes/g"
alias vh="cl /Volumes/h"
alias vm="cl /Volumes/Mac"
alias jdk="cl /Library/Java/JavaVirtualMachines"

alias unity="/Applications/Unity/Unity.app/Contents/MacOS/Unity"
alias yf="youtube-dl -F "
alias yd="youtube-dl -f 137+140 "
alias yd6="youtube-dl -f 136+140 "
alias yd5="youtube-dl -f 135+140 "
alias yd4="youtube-dl -f 134+140 "

alias "ecd=adb logcat -v long > log.txt"
alias "ap=adb pull /data/anr/traces.txt"
alias rh="rm \#*.java\# .\#*.java"
alias rr="rm \#*.org\# .\#*.org"
alias e="emacs"
alias jc="javac "
alias j="java "
alias sc="scalac "
alias s="scala "
alias e="emacs"
alias g='g++'
alias a="./a.out"
alias ge="gedit"
alias sl="/Applications/Sublime\ Text.app/Contents/MacOS/sublime_text"
alias sch="scrcpy --lock-video-orientation 1"

alias kct="kotlinc tmp.kt "
alias kt="kotlin TmpKt"

alias e="/Applications/Emacs.app/Contents/MacOS/Emacs"
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
# emacs dump
alias edm="emacs --batch -q -l ~/.emacs.d/dump.el"
# emacs started from dump file
alias ed="emacs --dump-file=\"/Users/heyan/.emacs.d/emacs.pdmp\""
alias eddb="emacs --dump-file=\"/Users/heyan/.emacs.d/emacs.pdmp\" --debug-init"
# 启动emacs client
alias ec="emacsclient -a=emacs -c"

alias "df=rm /Users/qunyan/Library/Application\ Support/deepwaterooo/AuthSampleTest/**/game*"
alias "ggs=cl /Users/qunyan/Library/Application\ Support/deepwaterooo/AuthSampleTest/"

alias "tel=cd /Users/qunyan/Library/Logs/Unity/"
#alias "el=chmod 777 /Users/qunyan/Library/Logs/Unity/Editor.log && emacs /Users/qunyan/Library/Logs/Unity/Editor.log &"
alias "el=emacs /Users/qunyan/Library/Application\ Support/deepwaterooo/AuthSampleTest/log.txt &"
alias "ei=/Applications/Emacs.app/Contents/MacOS/Emacs ~/.emacs.d/init.el &"
# alias "ed=/Applications/Emacs.app/Contents/MacOS/Emacs ~/.emacs.d/dump.el &"
alias "si=/Applications/Sublime\ Text.app/Contents/MacOS/Sublime_Text ~/.emacs.d/init.el &"

alias "edi=emacs --dump-file=\"/Users/heyan/.emacs.d/emacs.pdmp\" ~/.emacs.d/init.el &"
alias "edd=emacs --dump-file=\"/Users/heyan/.emacs.d/emacs.pdmp\" ~/.emacs.d/dump.el &"

# alias "eb=/Applications/Emacs.app/Contents/MacOS/Emacs ~/.bashrc &"
alias "ez=/Applications/Emacs.app/Contents/MacOS/Emacs ~/.zshrc &"
alias "edz=emacs --dump-file=\"/Users/heyan/.emacs.d/emacs.pdmp\"  ~/.zshrc &"
alias "sz=/Applications/Sublime\ Text.app/Contents/MacOS/Sublime_Text ~/.zshrc &"

alias "er=emacs readme.org &"
alias "eed=cd ~/.emacs.d/"
alias "edb=/Applications/Emacs.app/Contents/MacOS/Emacs --debug-init"
alias "es=cd ~/.emacs.d/elpa/yasnippet-0.12.2/snippets/"
alias "tv=cd /Users/qunyan/Movies/Mac\ Screen\ Recorder/tetrisVideos"
alias "um=cd /Users/qunyan/unity/uMVVM/Assets/Sources"
alias "yl=cd /Users/qunyan/yunlangZhuZuoAndroid/trunk/client/trunk/Assets/Scripts/Framework/TestSamples"

alias "mc=mpicc"
alias "mr=mpirun"
alias "h=cd ~"
alias "dc=cd /Users/qunyan/Desktop && rm *.toc && rm *.aux && rm *.out && rm *.pyg && rm *.gz && rm *.log"
alias cls='clear'
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias llt="ls -lt"
alias up='cd ..'
alias cl="cd";
alias ht="history"
alias dl="cd ~/Downloads/"

alias g="ghc --make "
alias ga="git add ."
alias gs="git status"
alias gr="git rm --cached "
alias gc="git commit -m"
alias gl="git log"
alias gp="git push origin master"

alias mn="/Library/Frameworks/Mono.framework/Versions/Current/Commands/mono" # mono
alias cscs="mono /Users/qunyan/unity/cs-script/bin/linux/ubuntu/build/cs-script_3.27.5.0/cscs.exe"
alias cscr="mono /Users/qunyan/unity/cs-script/bin/linux/ubuntu/build/cs-script_3.27.5.0/cscs.exe -r:/Applications/Unity_2018.1.0f2/Unity.app/Contents/Managed/UnityEngine.dll "
alias cscra="mono /Users/qunyan/unity/cs-script/bin/linux/ubuntu/build/cs-script_3.27.5.0/cscs.exe /r:UnityEngine.dll /r:Assembly-CSharp.dll /t:library /out:myfile.dll filename.cs"
alias nuget="mono /usr/local/bin/nuget.exe"
alias sur="source ~/.zshrc"

# show hidden files && hide hidden files
alias sh="defaults write com.apple.finder AppleShowAllFiles -boolean true"
alias kf="killall Finder"
alias hh="defaults write com.apple.finder AppleShowAllFiles -boolean false"

# for cd & ls in one
chpwd () {
      ls   
}

#alias "ie=ibus exit"
#alias "is=ibus-setup"
#/usr/bin/zsh ~/ibus_run.sh   # don't need this one anymore
#/bin/bash ~/.middle-click.sh   # keyboard layout is different now, search later for mac


[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

autoload -U compinit
compinit

# For autocompletion of command line switches for aliases
setopt completealiases
setopt AUTO_LIST
setopt AUTO_MENU


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
#eval $(dircolors -b)
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
#		    ZSH_THEME="angoster"

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
# FOR mono
export PATH=/Library/Frameworks/Mono.framework/Versions/Current/bin:${PATH}
# export PATH=/Library/Frameworks/Mono.framework/:${PATH}


# for pygmentize
export PATH=/Users/heyan/Library/Python/2.7/bin:${PATH}



pb-kill-line () {
  zle kill-line
  echo -n $CUTBUFFER | pbcopy
}
pb-kill-whole-line () {
  zle kill-whole-line
  echo -n $CUTBUFFER | pbcopy
}
pb-backward-kill-word () {
  zle backward-kill-word
  echo -n $CUTBUFFER | pbcopy
}
pb-kill-word () {
  zle kill-word
  echo -n $CUTBUFFER | pbcopy
}
pb-kill-buffer () {
  zle kill-buffer
  echo -n $CUTBUFFER | pbcopy
}
pb-copy-region-as-kill () {
  zle copy-region-as-kill
  echo -n $CUTBUFFER | pbcopy
}
pb-copy-region-as-kill-deactivate-mark () {
  zle pb-copy-region-as-kill
  zle set-mark-command -n -1
}
pb-yank () {
  CUTBUFFER=$(pbpaste)
  zle yank
}
pb-kill-region () {
  zle kill-region
  echo -n $CUTBUFFER | pbcopy
}
zle -N pb-kill-line
zle -N pb-kill-whole-line
zle -N pb-backward-kill-word
zle -N pb-kill-word
zle -N pb-kill-buffer
zle -N pb-copy-region-as-kill
zle -N pb-copy-region-as-kill-deactivate-mark
zle -N pb-yank
zle -N pb-kill-region

bindkey -e '^SPC' set-mark-command
bindkey '^k' pb-kill-line
bindkey '^u' pb-kill-whole-line
#bindkey -e '\eW' x-copy-region-as-kill
#bindkey -e '^[w' x-copy-region-as-kill
bindkey -e '^[w' pb-copy-region-as-kill
bindkey '^[w' pb-copy-region-as-kill-deactivate-mark
bindkey -e '^w' pb-kill-region
bindkey -e '^y' pb-yank


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

# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk8/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-16.0.1.jdk/Contents/Home
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home
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
#source ~/.nvm/nvm.sh

# for Ruby
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# source ~/.bashrc

#gradle home
GRADLE_HOME=/Applications/Android\ Studio.app/Contents/gradle/gradle-5.0/
export PATH=$GRADLE_HOME/bin/:$PATH

# for basicTex
export PATH=/Library/TeX/texbin:$PATH

# for Sublime Text
export PATH=/Applications/Sublime\ Text.app/Contents/MacOS:$PATH

# for Android Studio
export PATH=/Users/qunyan/Library/Android/sdk/platform-tools:/Users/qunyan/Library/Android/sdk/tools:$PATH
#export PATH=/usr/local/texlive/2015basic/bin/universal-darwin:$PATH

# for scala
SCALA_HOME="/Users/qunyan/Documents/summer16/scala/scala-2.11.8"
export PATH=/Users/qunyan/Documents/summer16/scala/scala-2.11.8/bin:$PATH

# /usr/local/bin/
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:/Users/qunyan/Library/Android/sdk/ndk-bundle

export PATH=/usr/local/share/dotnet:$PATH
export PATH=/Users/qunyan/Library/Android/sdk/platform-tools/adb:$PATH
