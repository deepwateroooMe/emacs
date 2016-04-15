#cd ~/120/lab4/

alias "e=emacs"
alias "ge=gedit"

alias "g=g++"
alias "a=./a.out"

alias "ec=~/installed/adt-bundle-linux-x86_64-20140702/eclipse/eclipse &"
alias "ee=emacs ~/.emacs &"
alias "eb=emacs ~/.bashrc &"
alias "ez=emacs ~/.zshrc &"
alias "eed=cd ~/.emacs.d"
alias "edb=emacs --debug-init"
alias "h=cd ~"
alias "z=zsh"

alias "l=ls"
alias "ll=ls -l"
alias "la=ls -a"
alias "lla=ls -la"
alias "llt=ls -lt"
alias "up=cd .."
alias "z=xter -geometry 75*45+4005+0"

# for Android sdk
#export PATH=/home/jenny/installed/adt-bundle-linux-x86_64-20140702/sdk/platform-tools/:$PATH

# followed this link
# http://tutorialforlinux.com/2013/11/26/how-to-install-android-sdk-tools-only-on-linux-mint-16-petra-easy-guide/
export PATH=/opt/adt-bundle-linux-x86_64-20140702/sdk/platform-tools/:$HOME/.rvm/bin:$PATH

#alias "ie=ibus exit"
#alias "is=ibus-setup"
#/bin/bash ~/ibus_run.sh

source ~/.rvm/scripts/rvm
source ~/.nvm/nvm.sh
