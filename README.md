# ruby-installation
Painless Ruby Installation (Autoinstaller Ruby)

![alt text](https://github.com/zeroc0d3/ruby-installation/blob/master/snapshot/install_ruby1.png)

![alt text](https://github.com/zeroc0d3/ruby-installation/blob/master/snapshot/install_ruby2.png)

## Features
- [X] Using `rbenv` Package Manager
- [X] Using `rvm` Package Manager
- [X] Support Docker Installation

## Configuration
* Ruby Version
  ```
  DEFAULT_VERSION='2.4.2'
  ```
* Install with `rbenv` Package Manager
  ```
  DEFAULT_PACKAGE='rbenv'
  ```
* Install with `rvm` Package Manager
  ```
  DEFAULT_PACKAGE='rvm'
  ```
* Your Username & Path (Home)
  ```
  USERNAME='zeroc0d3'         (default: USERNAME=`echo $USER`)
  PATH_HOME='/home/zeroc0d3'  (default: PATH_HOME=`echo $HOME`)
  ```    
* Bash (`~/.bashrc`) and/or ZSH (`~/.zshrc`) Configuration
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

      # set PATH alternatives using this:
      [[ -s "$RVM_ROOT/scripts/rvm"  ]] && source "$RVM_ROOT/scripts/rvm"
    fi 
  fi
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
  # -) copy installation scripts to /opt
  #-----------------------------------------------------------------------------
  COPY ./rootfs/root/.zshrc /root/.zshrc
  COPY ./rootfs/root/.bashrc /root/.bashrc
  COPY ./rootfs/root/ruby.sh /etc/profile.d/ruby.sh
  COPY ./rootfs/root/install_ruby.sh /opt/install_ruby.sh
  COPY ./rootfs/root/reload_shell.sh /opt/reload_shell.sh
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
  
## Running Installation
* [X] Configure Ruby Version
* [X] Configure Package Manager
* [X] Configure Username & Path
* [X] Configure Bash (`~/.bashrc`) and/or ZSH (`~/.zshrc`)
* Type command:
  ```
  ./install_ruby.sh
  ```
