# check for .profile and load if it exists
[ -r $HOME/.profile ] && source $HOME/.profile

# check for .bashrc and load if it exists
[ -r $HOME/.bashrc ] && source $HOME/.bashrc

