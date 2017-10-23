# ruby-installation
Simple Command For Ruby Installation

Features:
- [X] Using `rbenv` Package Manager
- [X] Using `rvm` Package Manager
- [X] Support Docker Installation

## Configuration
* Ruby Version
   ```
   DEFAULT_VERSION='2.4.2'
   ```
* Install with `rbenv`
   ```
   DEFAULT_PACKAGE='rbenv'
   ```
* Install with `rvm`
   ```
   DEFAULT_PACKAGE='rvm'
   ```
* Your Username & Path (Home)
   ```
   USERNAME='zeroc0d3'
   PATH_HOME='/home/zeroc0d3'
   ```    
   
## Docker Installation
* From Image
   ```
   FROM zeroc0d3lab/centos-base-consul:latest
   ```
* Environment
  ```
  ENV RUBY_VERSION=2.4.2
  ENV RUBY_PACKAGE="rbenv"
      # ("rbenv" = using rbenv package manager, "rvm" = using rvm package manager)
  ```
* Create `rootfs/root` folder
* Copy all sources in this repo to `rootfs/root` folder
* Configure as root 
   ```
   USERNAME='root'
   PATH_HOME='/root'
   ```    
* Install Ruby in Dockerfile
  ```
  #-----------------------------------------------------------------------------
  # Prepare Install Ruby
  # -) copy .zshrc to /root
  # -) copy .bashrc to /root
  #-----------------------------------------------------------------------------
  COPY ./rootfs/root/.zshrc /root/.zshrc
  COPY ./rootfs/root/.bashrc /root/.bashrc
  COPY ./rootfs/root/ruby.sh /etc/profile.d/ruby.sh
  COPY ./rootfs/root/install_ruby.sh /opt/install_ruby.sh
  RUN sudo /bin/sh /opt/install_ruby.sh

  #-----------------------------------------------------------------------------
  # Copy package dependencies in Gemfile
  #-----------------------------------------------------------------------------
  COPY ./rootfs/root/Gemfile /opt/Gemfile
  COPY ./rootfs/root/Gemfile.lock /opt/Gemfile.lock
  #-----------------------------------------------------------------------------
  # Install Ruby Packages (rbenv/rvm)
  #-----------------------------------------------------------------------------
  COPY ./rootfs/root/gems.sh /opt/gems.sh
  RUN sudo /bin/sh /opt/gems.sh
  ```
* Bash / ZSH Configuration
  ```
  ### Path Ruby RBENV / RVM ###
  export RBENV_ROOT="$HOME/.rbenv"
  export RVM_ROOT="/usr/local/rvm"

  ### rbenv (Ruby) default ###
  if [ -d "$RBENV_ROOT" ] 
  then
    export PATH="$RBENV_ROOT/bin:${PATH}"
    eval "$(rbenv init -)"
    export PATH="$RBENV_ROOT/plugins/ruby-build/bin:$PATH"
    # export RAILS_ENV=staging
  else
    ### rvm (Ruby) - alternative ###
    if [ -d "$RVM_ROOT" ] 
    then
      export PATH="$PATH:$RVM_ROOT/bin"
      source $RVM_ROOT/scripts/rvm

      # Set PATH alternatives using this:
      [[ -s "$RVM_ROOT/scripts/rvm"  ]] && source "$RVM_ROOT/scripts/rvm"

      ### rvm selector ###
      # function gemdir {
      #   if [[ -z "$1" ]] ; then
      #     echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
      #   else
      #     rvm "$1"
      #     cd $(rvm gemdir)
      #     pwd
      #   fi
      # }
    fi 
  fi
  ```
  
## Running Installation
* Running command:
  ```
  ./install_ruby.sh
  ```
