# ~/.bashrc: executed by bash(1) for non-login shells.

export PS1='\[\033[0;32m\]\h:\w\$ \[\033[0m\]'
umask 022 # default: only user can write

alias ts='tail -f /var/log/syslog'
