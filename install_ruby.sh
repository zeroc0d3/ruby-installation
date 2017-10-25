#!/bin/sh

DATE=`date '+%Y-%m-%d %H:%M:%S'`
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
  
logo() {
  echo "--------------------------------------------------------------------------"
  echo "  __________                  _________ _______       .___________        "
  echo "  \____    /___________  ____ \_   ___ \\   _  \    __| _/\_____  \  LAB  "
  echo "    /     // __ \_  __ \/  _ \/    \  \//  /_\  \  / __ |   _(__  <       "
  echo "   /     /\  ___/|  | \(  <_> )     \___\  \_/   \/ /_/ |  /       \      "
  echo "  /_______ \___  >__|   \____/ \______  /\_____  /\____ | /______  /      "
  echo "          \/   \/                     \/       \/      \/        \/       "
  echo "--------------------------------------------------------------------------"
  echo " Date / Time: $DATE"
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

reload_env_shell() {
  if [ "$INSTALL_PACKAGE" = "rbenv" ]
  then
    exec $SHELL
  else
    source $RVM_ROOT/scripts/rvm
  fi
}

check_env() {
  reload_env_shell
  echo "--------------------------------------------------------------------------"
  echo "## Load Environment: "
  
  if [ "$INSTALL_PACKAGE" = "rbenv" ]
  then
    if [ "$WHAT_SHELL" = "`which zsh`" ] || [ "$WHAT_SHELL" = "zsh" ]
    then  
      echo "   $PATH_HOME/.zshrc"
    else
      if [ "$WHAT_SHELL" = "`which bash`" ] || [ "$WHAT_SHELL" = "bash" ]
      then
        echo "   $PATH_HOME/.bashrc"
      else 
        echo "   $PATH_HOME/.bashrc"
      fi
    fi
  else
    echo "   $RVM_ROOT/scripts/rvm"
  fi  

  echo ""
}

cleanup() {
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
}

install_ruby() {
  echo "--------------------------------------------------------------------------"
  echo "## Install Ruby Version: " 
  echo "   $INSTALL_VERSION"
  echo "## Using Ruby Package: "
  echo "   $INSTALL_PACKAGE"
  echo ""
  cleanup
  if [ "$INSTALL_PACKAGE" = "rbenv" ]
  then
    #-----------------------------------------------------------------------------
    # Get repo rbenv
    #-----------------------------------------------------------------------------
    git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT \
      && git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build 
    
    #-----------------------------------------------------------------------------
    # Install Ruby with rbenv (default)
    #-----------------------------------------------------------------------------
    $RBENV_ROOT/bin/rbenv install $INSTALL_VERSION \
      && $RBENV_ROOT/bin/rbenv global $INSTALL_VERSION \
      && $RBENV_ROOT/bin/rbenv rehash 
  else
    #-----------------------------------------------------------------------------
    # Get repo rvm
    #-----------------------------------------------------------------------------
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
  fi
}

validate_installation() {
  echo "--------------------------------------------------------------------------"
  echo "## Ruby Version: "
  RUBY=`which ruby`
  RUBY_V=`$RUBY -v`
  echo "   $RUBY_V"
  echo ""
  echo "## Path Ruby: "
  echo "   $RUBY"
  echo ""
  echo "## Path Gem: "
  GEM=`which gem`
  echo "   $GEM"
  echo ""
}

install_bundle() {
  echo "--------------------------------------------------------------------------"
  echo "## Install Bundle: "
  echo "   $GEM install bundle"
  echo ""
  $GEM install bundle
}

main() {
  logo
  check_version
  check_ruby_package
  install_ruby
  check_env
  validate_installation
  install_bundle
}

### START HERE ###
main
