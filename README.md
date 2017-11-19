# ruby-installation
Painless Ruby Installation (Autoinstaller Ruby)

![Progress-1](https://github.com/zeroc0d3/ruby-installation/blob/master/snapshot/install_ruby1.png)
![Progress-2](https://github.com/zeroc0d3/ruby-installation/blob/master/snapshot/install_ruby2.png)

## Dashboard

$VERSION = The Latest Version Stable
```
==========================================================================
  __________                  _________ _______       .___________        
  \____    /___________  ____ \_   ___ \   _  \    __| _/\_____  \  LAB  
    /     // __ \_  __ \/  _ \/    \  \//  /_\  \  / __ |   _(__  <       
   /     /\  ___/|  | \(  <_> )     \___\  \_/   \/ /_/ |  /       \      
  /_______ \___  >__|   \____/ \______  /\_____  /\____ | /______  /      
          \/   \/                     \/       \/      \/        \/       
--------------------------------------------------------------------------
# RUBY INSTALLATION SCRIPT :: ver-$VERSION
==========================================================================
# BEGIN PROCESS..... (Please Wait)  
# Start at: 2017-11-19 19:49:17  

[ 2017-11-19 19:49:17 ] ##### Install Ruby Version: 
[ 2017-11-19 19:49:17 ]       2.4.2 

[ 2017-11-19 19:49:17 ] ##### Using Ruby Package: 
[ 2017-11-19 19:49:17 ]       rbenv 

[ 2017-11-19 19:49:17 ] ##### Archiving Old Ruby Packages: 

[ 2017-11-19 19:49:17 ] :: [ ✔ ]  Old Ruby Packages Archived... 

[ 2017-11-19 19:49:17 ] ##### Download RBENV Repository: 

[ 2017-11-19 19:49:17 ] :: [ ✔ ]  Ruby Installed... 

[ 2017-11-19 19:49:17 ] ##### Load Environment: 
[ 2017-11-19 19:49:17 ]       /home/zeroc0d3/.zshrc 

[ 2017-11-19 19:49:17 ] :: [ ✔ ]  Environment Loaded... 

[ 2017-11-19 19:49:17 ] ##### Ruby Version: 
[ 2017-11-19 19:49:17 ]       ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-linux] 

[ 2017-11-19 19:49:17 ] ##### Path Ruby: 
[ 2017-11-19 19:49:17 ]       /home/zeroc0d3/.rbenv/shims/ruby   

[ 2017-11-19 19:49:17 ] ##### Path Gem: 
[ 2017-11-19 19:49:17 ]       /home/zeroc0d3/.rbenv/shims/gem   

[ 2017-11-19 19:49:17 ] ##### Install Bundle: 
[ 2017-11-19 19:49:17 ]       /home/zeroc0d3/.rbenv/shims/gem install bundle   

[ 2017-11-19 19:49:17 ] :: [ ✔ ]  Bundle Installed... 
==========================================================================
# Finish at: 2017-11-19 19:49:17  
# END PROCESS.....  
```

## Features
- [X] Using `rbenv` Package Manager
- [X] Using `rvm` Package Manager
- [X] Support Docker Installation

## Documentation
* Configuration & How-To, see
[**Wiki Documentation**](https://github.com/zeroc0d3/ruby-installation/wiki)

## Roadmap
* - [X] Check target Ruby version installation
* - [X] Check target Ruby package manager (rbenv / rvm)
* - [X] Check old Ruby Installation, if exist then backup / archive it
* - [X] Running Installation with all configuration (version & package manager) 
* - [X] Load Environment after successfully installation
* - [X] Validate Installation

## License
[**MIT License**](https://github.com/zeroc0d3/ruby-installation/blob/master/LICENSE)