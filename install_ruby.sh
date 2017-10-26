#!/bin/sh

DEFAULT_VERSION="2.4.2"
DEFAULT_PACKAGE="rbenv"
INSTALL_VERSION=$DEFAULT_VERSION
INSTALL_PACKAGE=$DEFAULT_PACKAGE
USERNAME=`echo $USER`
PATH_HOME=`echo $HOME`

### Path Installation Ruby Package Manager ###
RBENV_ROOT="$PATH_HOME/.rbenv"
RVM_ROOT="/usr/local/rvm"

### Path Backup Old Ruby Package Manager ###
SNAP_BACKUP=`date '+%Y%m%d%H%M'`
PATH_BACKUP_RBENV=$PATH_HOME"/__rbenv_"$SNAP_BACKUP
PATH_BACKUP_RVM=$PATH_HOME"/__rvm_"$SNAP_BACKUP
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
  echo "\033[22;31m          \/   \/                     \/       \/      \/        \/       \033[0m\n"
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

check_version() {
  if [ "${RUBY_VERSION}" != "" ]
  then
    INSTALL_VERSION=${RUBY_VERSION}   
  fi
}

check_ruby_package() {
  if [ "${RUBY_VERSION}" != "" ]
  then
    INSTALL_PACKAGE=${RUBY_PACKAGE}   
  fi
}

cleanup() {
  get_time
  echo "\033[22;34m[ $DATE ] ##### Archiving Old Ruby Packages: \033[0m" 

  if [ "$INSTALL_PACKAGE" = "rbenv" ]
  then
    if [ -d "$RBENV_ROOT" ]; then 
      mv $RBENV_ROOT $PATH_BACKUP_RBENV 
    fi 
  else 
    if [ -d "$RVM_ROOT" ]; then 
      sudo mv $RVM_ROOT $PATH_BACKUP_RVM 
    fi     
  fi
  sudo rm -f /etc/profile.d/rvm.sh
  echo ""
  get_time
  echo "\033[22;32m[ $DATE ] :: [ ✔ ] \033[22;32m Old Ruby Packages Archived... \033[0m\n"
}

load_env() {
  get_time
  echo "\033[22;34m[ $DATE ] ##### Load Environment: \033[0m" 

  ### Running Ruby Environment ###
  /bin/sh ./ruby.sh
    
  if [ "$INSTALL_PACKAGE" = "rbenv" ]
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

reload_shell() {
  if [ "$INSTALL_PACKAGE" = "rbenv" ]
  then
    exec $SHELL
  else
    source $RVM_ROOT/scripts/rvm
  fi
}

install_ruby() {
  get_time
  echo "\033[22;34m[ $DATE ] ##### Install Ruby Version: \033[0m" 
  echo "\033[22;32m[ $DATE ]       $INSTALL_VERSION \033[0m\n"
  get_time
  echo "\033[22;34m[ $DATE ] ##### Using Ruby Package: \033[0m" 
  echo "\033[22;32m[ $DATE ]       $INSTALL_PACKAGE \033[0m\n"
  cleanup
  if [ "$INSTALL_PACKAGE" = "rbenv" ]
  then
    #-----------------------------------------------------------------------------
    # Get repo rbenv
    #-----------------------------------------------------------------------------
    get_time
    echo "\033[22;34m[ $DATE ] ##### Download RBENV Repository: \033[0m" 

    git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT \
      && git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build 
    
    #-----------------------------------------------------------------------------
    # Install Ruby with rbenv (default)
    #-----------------------------------------------------------------------------
    $RBENV_ROOT/bin/rbenv install $INSTALL_VERSION \
      && $RBENV_ROOT/bin/rbenv global $INSTALL_VERSION \
      && $RBENV_ROOT/bin/rbenv rehash 
    
    echo ""
    get_time
    echo "\033[22;32m[ $DATE ] :: [ ✔ ] \033[22;32m Ruby Installed... \033[0m\n"
  else
    #-----------------------------------------------------------------------------
    # Get repo rvm
    #-----------------------------------------------------------------------------
    get_time
    echo "\033[22;34m[ $DATE ] ##### Download RVM Repository: \033[0m" 
  
    curl -sSL https://rvm.io/mpapis.asc | gpg2 --import \
      && curl -sSL https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer | sudo bash -s stable \
      && sudo usermod -a -G rvm root \
      && sudo usermod -a -G rvm $USERNAME \
      && sudo cp ruby.sh /etc/profile.d/rvm.sh \
      && umask g+w \
      && sudo $RVM_ROOT/bin/rvm get head --auto-dotfiles 

    #-----------------------------------------------------------------------------
    # Install Ruby with rvm (alternatives)
    #-----------------------------------------------------------------------------
    $RVM_ROOT/bin/rvm install $INSTALL_VERSION \
      && $RVM_ROOT/bin/rvm use $INSTALL_VERSION --default 
  
    echo ""
    get_time
    echo "\033[22;32m[ $DATE ] :: [ ✔ ] \033[22;32m Ruby Installed... \033[0m\n"
  fi
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
  echo "\033[22;32m[ $DATE ] :: [ ✔ ] \033[22;32m Bundle Installed... \033[0m"
}

main() {
  header
  check_version
  check_ruby_package
  install_ruby
  load_env
  validate_installation
  install_bundle
  footer
  reload_shell
}

### START HERE ###
main
