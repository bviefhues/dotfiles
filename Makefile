DOTFILES = vimrc bash_profile bashrc

all: pull links

checklinks:
	# ensure that we do not overwrite possibly existing regular files
	for DOTFILE in $(DOTFILES); do \
		FULLDOTFILE=~/.$$DOTFILE; \
		if [ -e $$FULLDOTFILE -a ! -L $$FULLDOTFILE ]; then \
			echo "Error: $$FULLDOTFILE exists and is not a symlink"; \
			exit 1; \
		fi; \
	done

links: checklinks
	for DOTFILE in $(DOTFILES); do \
		ln -svf `pwd`/$$DOTFILE ~/.$$DOTFILE; \
	done

pull:
	git pull

