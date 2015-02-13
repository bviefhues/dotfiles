DOTFILES = vimrc bash_profile bashrc

all: pull links

links: 
	for DOTFILE in $(DOTFILES) ; do \
		ln -svf `pwd`/$$DOTFILE ~/.$$DOTFILE; \
	done

pull:
	git pull

