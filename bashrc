# ~/.bashrc: executed by bash(1) for non-login shells.

# exit if shell is not interactive
[[ $- == *i* ]] || return 0

export PS1='\[\033[0;32m\]\u@\h:\w \[\033[0m\]'
umask 022 # default: only user can write

case `uname` in
    FreeBSD)
        alias ts='tail -f /var/log/messages'
        export EDITOR=/usr/local/bin/vim
        export VISUAL=/usr/local/bin/vim
        ;;
    Linux)
        alias ts='tail -f /var/log/syslog'
        export EDITOR=/usr/bin/vim
        export VISUAL=/usr/bin/vim
        ;;
    Darwin) # OS X
        export EDITOR=/usr/bin/vim
        export VISUAL=/usr/bin/vim
        ;;
esac

