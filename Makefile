install-jdd: install-common install-linux install-extras
install-musicmaker: install-common install-linux
install-workmac: install-common install-mac install-work

install-common:
	makedir -p "$(HOME)/workspace/planning/notes"
	ln -sf "$(HOME)/workspace/planning/notes" "$(HOME)/notes"
        ln -sf "$(realpath .bashrc)" "$(HOME)"
        ln -sf "$(realpath emacs-config/.emacs)" "$(HOME)"
        ln -sf "$(realpath emacs-config/.emacs.d)" "$(HOME)"
        ln -sf "$(realpath .git-completion.bash)" "$(HOME)"
        ln -sf "$(realpath .gitignore)" "$(HOME)"
        ln -sf "$(realpath .screenrc)" "$(HOME)"
        ln -sf "$(realpath .profile)" "$(HOME)"
        ln -sf "$(realpath .subversion)" "$(HOME)"
        ln -sf "$(realpath .tmux.conf)" "$(HOME)"
        ln -sf "$(realpath .nethackrc)" "$(HOME)"

install-linux:
        ln -sf "$(realpath .Xdefaults)" "$(HOME)"
        ln -sf "$(realpath .xinitrc)" "$(HOME)"
        ln -sf "$(realpath .xmodmap)" "$(HOME)"
        ln -sf "$(realpath .zshrc)" "$(HOME)"
        ln -sf "$(realpath .bashrc.LINUX)" "$(HOME)/.bash-machine"
        ln -sf "$(realpath .tmux-linux.conf)" "$(HOME)/.tmux-local.conf"
        ln -sf "$(realpath .rspec)" "$(HOME)/.rspec"
        ln -sf "$(realpath .pydistutils.cfg)" "$(HOME)/.pydistutils.cfg"
        ln -sf "$(realpath .virtualenv)" "$(HOME)/.virtualenv"
        ln -sf "$(realpath .signature-for-newsgroups)" "$(HOME)/.signature-for-newsgroups"
        ln -sf "$(realpath .signature)" "$(HOME)/.signature"

install-mac:
        ln -sf "$(realpath .tmux-mac.conf)" "$(HOME)/.tmux-local.conf"

install-extras:
        ln -sf "$(realpath .conkyrc)" "$(HOME)"
        ln -sf "$(realpath .dzen)" "$(HOME)"
        ln -sf "$(realpath .xmonad)" "$(HOME)"

install-work:
        ln -sf "$(realpath .bashrc.DARWIN)" "$(HOME)/.bash-machine"
