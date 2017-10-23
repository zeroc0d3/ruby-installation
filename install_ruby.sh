#!/bin/sh

DATE=`date '+%Y-%m-%d %H:%M:%S'`
DEFAULT_VERSION='2.4.2'
DEFAULT_PACKAGE='rbenv'
INSTALL_VERSION=$DEFAULT_VERSION
INSTALL_PACKAGE=$DEFAULT_PACKAGE
USERNAME='zeroc0d3'
PATH_HOME='/home/zeroc0d3'
RBENV_ROOT="$PATH_HOME"
RVM_ROOT="/usr/local/rvm"

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
  WHAT_SHELL=`$SHELL -c 'echo $0'`
  if [ $WHAT_SHELL = `which zsh` ] || [ $WHAT_SHELL = 'zsh' ]
  then  
    ### source ~/.zshrc ####
    exec $SHELL
  else
    if [ $WHAT_SHELL = `which bash` ] || [ $WHAT_SHELL = 'bash' ]
    then
      ### source ~/.bashrc ####
      exec $SHELL
    else 
      ### source ~/.bashrc ####
      exec $SHELL
    fi
  fi
  # exit
}

load_env() {
  echo "--------------------------------------------------------------------------"
  echo "## Load Environment: "
  echo "   $PATH_HOME/.bashrc"
  echo ""
  reload_env_shell
}

cleanup() {
  rm -rf $RBENV_ROOT/.rbenv \
    && sudo rm -rf $RVM_ROOT \
    && sudo rm -f /etc/profile.d/rvm.sh
}

get_repo_package() {
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
    git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT/.rbenv \
      && git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/.rbenv/plugins/ruby-build \
      && exec $SHELL 
  else
    #-----------------------------------------------------------------------------
    # Get repo rvm
    #-----------------------------------------------------------------------------
    curl -sSL https://rvm.io/mpapis.asc | gpg2 --import \
      && curl -sSL https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer | sudo bash -s stable \
      && sudo usermod -a -G rvm root \
      && sudo usermod -a -G rvm $USERNAME \
      && sudo cp ruby.sh /etc/profile.d/rvm.sh \
      && source /etc/profile.d/rvm.sh \
      && umask g+w \
      && sudo $RVM_ROOT/bin/rvm get head --auto-dotfiles 
  fi
}

install_ruby() {
  if [ "$INSTALL_PACKAGE" = "rbenv" ]
  then
    #-----------------------------------------------------------------------------
    # Install Ruby with rbenv (default)
    #-----------------------------------------------------------------------------
    $RBENV_ROOT/.rbenv/bin/rbenv install $INSTALL_VERSION \
      && $RBENV_ROOT/.rbenv/bin/rbenv global $INSTALL_VERSION \
      && $RBENV_ROOT/.rbenv/bin/rbenv rehash \
      && $RBENV_ROOT/.rbenv/shims/ruby -v
  else
    #-----------------------------------------------------------------------------
    # Install Ruby with rvm (alternatives)
    #-----------------------------------------------------------------------------
    $RVM_ROOT/bin/rvm install $INSTALL_VERSION \
      && $RVM_ROOT/bin/rvm use $INSTALL_VERSION --default \
      && /usr/bin/ruby -v
  fi
}

check(){
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
  get_repo_package
  load_env
  install_ruby
  check
  install_bundle
}

### START HERE ###
main
