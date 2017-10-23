#!/bin/sh

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