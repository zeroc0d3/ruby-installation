#!/bin/sh

VER="1.1"                # script version
USERNAME=`echo $USER`    # default username
PATH_HOME=`echo $HOME`   # default home path 

### Path Installation Ruby Package Manager ###
RBENV_ROOT="$PATH_HOME/.rbenv"
RVM_ROOT="/usr/local/rvm"
WHAT_SHELL=`$SHELL -c 'echo $0'`

get_time() {
  DATE=`date '+%Y-%m-%d %H:%M:%S'`
}

logo() {
  clear
  echo "\033[22;32m==========================================================================\033[0m"
  echo "\033[22;31m  __________                  _________ _______       .___________        \033[0m"
  echo "\033[22;31m  \____    /___________  ____ \_   ___ \\   _  \    __| _/\_____  \  LAB  \033[0m"
  echo "\033[22;31m    /     // __ \_  __ \/  _ \/    \  \//  /_\  \  / __ |   _(__  <       \033[0m"
  echo "\033[22;31m   /     /\  ___/|  | \(  <_> )     \___\  \_/   \/ /_/ |  /       \      \033[0m"
  echo "\033[22;31m  /_______ \___  >__|   \____/ \______  /\_____  /\____ | /______  /      \033[0m"
  echo "\033[22;31m          \/   \/                     \/       \/      \/        \/       \033[0m"
  echo "\033[22;32m--------------------------------------------------------------------------\033[0m"
  echo "\033[22;32m# BUNDLE INSTALLATION SCRIPT :: ver-$VER                                  \033[0m"
}

header() {
  logo
  echo "\033[22;32m==========================================================================\033[0m"
  get_time
  echo "\033[22;31m# BEGIN PROCESS..... (Please Wait)  \033[0m"
  echo "\033[22;31m# Start at: $DATE  \033[0m\n"
}

footer() {
  echo "\033[22;32m==========================================================================\033[0m"
  get_time
  echo "\033[22;31m# Finish at: $DATE  \033[0m"
  echo "\033[22;31m# END PROCESS.....  \033[0m\n" 
}

load_env() {
  get_time
  echo "\033[22;34m[ $DATE ] ##### Load Environment: \033[0m" 

  ### Running Ruby Environment ###
  PWD=`pwd` 
  cd $PWD; /bin/sh ./ruby.sh
    
  if [ -d "$RBENV_ROOT" ] 
  then
    if [ "$WHAT_SHELL" = "`which zsh`" ] || [ "$WHAT_SHELL" = "zsh" ]
    then  
      echo "\033[22;32m[ $DATE ]       $PATH_HOME/.zshrc \033[0m\n"
    else
      if [ "$WHAT_SHELL" = "`which bash`" ] || [ "$WHAT_SHELL" = "bash" ]
      then
        echo "\033[22;32m[ $DATE ]       $PATH_HOME/.bashrc \033[0m\n"
      else 
        echo "\033[22;32m[ $DATE ]       $PATH_HOME/.bashrc \033[0m\n"
      fi
    fi
  else
    echo "\033[22;32m[ $DATE ]       $RVM_ROOT/scripts/rvm \033[0m\n"
  fi    
  get_time
  echo "\033[22;32m[ $DATE ] :: [ ✔ ] \033[22;32m Environment Loaded... \033[0m\n"
}

validate_installation() {
  get_time
  echo "\033[22;34m[ $DATE ] ##### Ruby Version: \033[0m" 
  RUBY=`which ruby`
  RUBY_V=`$RUBY -v`
  echo "\033[22;32m[ $DATE ]       $RUBY_V \033[0m\n"
  get_time
  echo "\033[22;34m[ $DATE ] ##### Path Ruby: \033[0m" 
  echo "\033[22;32m[ $DATE ]       $RUBY   \033[0m\n"  
  get_time
  echo "\033[22;34m[ $DATE ] ##### Path Gem: \033[0m" 
  GEM=`which gem`
  echo "\033[22;32m[ $DATE ]       $GEM   \033[0m\n"
}

install_bundle() {
  get_time
  echo "\033[22;34m[ $DATE ] ##### Install Bundle: \033[0m" 
  echo "\033[22;32m[ $DATE ]       $GEM install bundle   \033[0m\n"
  $GEM install bundle
  echo ""
  get_time
  echo "\033[22;32m[ $DATE ] :: [ ✔ ] \033[22;32m Bundle Installed... \033[0m\n"
}

reload_shell() {
  if [ -d "$RBENV_ROOT" ] 
  then
    exec $SHELL
  else
    source $RVM_ROOT/scripts/rvm
  fi
}

install_package() {
  get_time
  echo "\033[22;34m[ $DATE ] ##### Bundle Installation Package: \033[0m" 
  BUNDLE=`which bundle`
  echo "\033[22;32m[ $DATE ]       $BUNDLE install             \033[0m\n"
  $BUNDLE install
  echo ""
  get_time
  echo "\033[22;32m[ $DATE ] :: [ ✔ ] \033[22;32m Package Installed... \033[0m"
}

main() {
  header
  load_env
  validate_installation
  install_bundle
  install_package
  footer
}

### START HERE ###
main