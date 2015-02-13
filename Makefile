CWD != pwd
HOME != echo $$HOME

DOTFILES = vimrc bash_profile bashrc

all: pull links

links: 
	for DOTFILE in $(DOTFILES) ; do \
		ln -svf $(CWD)/$$DOTFILE $(HOME)/.$$DOTFILE; \
	done

pull:
	git pull

