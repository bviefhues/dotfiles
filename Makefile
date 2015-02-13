CWD != pwd
HOME != echo $$HOME

LINKFILES = vimrc

all: links

pull:
	git pull

links: $(LINKFILES)
	ln -svf $(CWD)/$(LINKFILES) $(HOME)/.$(LINKFILES)
