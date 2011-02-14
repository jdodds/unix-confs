install-jdd: install-common install-extras
install-musicmaker: install-common

install-common:
	ln -sf $(realpath .bashrc) $(HOME)
	ln -sf $(realpath .emacs) $(HOME)
	ln -sf $(realpath .emacs.d) $(HOME)
	ln -sf $(realpath .git-completion.bash) $(HOME)
	ln -sf $(realpath .gitconfig) $(HOME)
	ln -sf $(realpath .gitignore) $(HOME)
	ln -sf $(realpath .screenrc) $(HOME)
	ln -sf $(realpath .profile) $(HOME)
	ln -sf $(realpath .Xdefaults) $(HOME)
	ln -sf $(realpath .xinitrc) $(HOME)
	ln -sf $(realpath .xmodmap) $(HOME)

install-extras:
	ln -sf $(realpath .conkyrc) $(HOME)
	ln -sf $(realpath .dzen) $(HOME)
	ln -sf $(realpath hours.org) $(HOME)
	ln -sf $(realpath .xmonad) $(HOME)
