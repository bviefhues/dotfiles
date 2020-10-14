DOTFILES = vimrc bash_profile bashrc

all: pull links hammerspoon karabiner

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

hammerspoon:
	# only for macOS
	if [[ `uname` == "Darwin" ]]; then \
		mkdir -pv ~/.hammerspoon; \
		ln -svf `pwd`/hammerspoon_init.lua ~/.hammerspoon/init.lua; \
	fi

karabiner:
	# only for macOS
	if [[ `uname` == "Darwin" ]]; then \
		mkdir -pv ~/.config/karabiner; \
		ln -svf `pwd`/karabiner.json ~/.config/karabiner/karabiner.json; \
	fi

pull:
	git pull

