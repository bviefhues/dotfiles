# ~/.bashrc: executed by bash(1) for non-login shells.

# exit if shell is not interactive
[[ $- == *i* ]] || return 0

export PS1='\[\033[0;32m\]\u@\h:\w \[\033[0m\]'
umask 022 # default: only user can write

case `uname` in
    FreeBSD)
        alias ts='tail -f /var/log/messages'
        ;;
    Linux)
        alias ts='tail -f /var/log/syslog'
        ;;
    Darwin) # OS X
        ;;
esac

