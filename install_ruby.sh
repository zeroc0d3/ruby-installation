#!/bin/sh

DATE=`date '+%Y-%m-%d %H:%M:%S'`
DEFAULT_VERSION='2.4.2'
DEFAULT_PACKAGE='rbenv'
INSTALL_VERSION=$DEFAULT_VERSION
INSTALL_PACKAGE=$DEFAULT_PACKAGE
USERNAME='zeroc0d3'
PATH_HOME='/home/zeroc0d3'

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

load_env() {
  echo "--------------------------------------------------------------------------"
  echo "## Load Environment: "
  echo "   $PATH_HOME/.bashrc"
  echo ""
# source ~/.bashrc
  exec $SHELL
}

install_ruby() {
  echo "--------------------------------------------------------------------------"
  echo "## Install Ruby Version: " 
  echo "   $INSTALL_VERSION"
  echo "## Using Ruby Package: "
  echo "   $INSTALL_PACKAGE"
  echo ""

  if [ "$INSTALL_PACKAGE" = "rbenv" ]
  then
    #-----------------------------------------------------------------------------
    # Install Ruby with rbenv (default)
    #-----------------------------------------------------------------------------
    git clone https://github.com/rbenv/rbenv.git $PATH_HOME/.rbenv \
    && git clone https://github.com/rbenv/ruby-build.git $PATH_HOME/.rbenv/plugins/ruby-build \
    && exec $SHELL \
    && $PATH_HOME/.rbenv/bin/rbenv install $INSTALL_VERSION \
    && $PATH_HOME/.rbenv/bin/rbenv global $INSTALL_VERSION \
    && $PATH_HOME/.rbenv/bin/rbenv rehash \
    && $PATH_HOME/.rbenv/shims/ruby -v
  else
    #-----------------------------------------------------------------------------
    # Install Ruby with rvm (alternatives)
    #-----------------------------------------------------------------------------
    curl -sSL https://rvm.io/mpapis.asc | gpg2 --import \
    && curl -sSL https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer | sudo bash -s stable \
    && sudo usermod -a -G rvm root \
    && sudo usermod -a -G rvm $USERNAME \
    && source $PATH_HOME/.rvm/scripts/rvm \
    && $PATH_HOME/.rvm/bin/rvm install $INSTALL_VERSION \
    && $PATH_HOME/.rvm/bin/rvm use $INSTALL_VERSION --default \
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
  install_ruby
  load_env
  check
  install_bundle
}

### START HERE ###
main
