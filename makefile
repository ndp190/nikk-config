install: prerequisite \
    install-custom-script \
    install-karabiner \
    install-nvim \
    install-tmux \
    install-zsh \
    install-lynx \
    install-git \
    install-newsboat

prerequisite:
	chmod +x `pwd`/install-brew.sh `pwd`/install-node.sh `pwd`/install-pip.sh
	`pwd`/install-brew.sh
	`pwd`/install-node.sh
	`pwd`/install-pip.sh

install-custom-script:
	chmod +x `pwd`/custom-script/autogen-pyinit.sh `pwd`/custom-script/echo-colorized.sh
	ln -sf `pwd`/custom-script/autogen-pyinit.sh /usr/local/bin/autogen-pyinit
	ln -sf `pwd`/custom-script/echo-colorized.sh /usr/local/bin/echo-colorized

install-karabiner:
	mkdir -p ~/.config/karabiner
	ln -sf `pwd`/karabiner.json ~/.config/karabiner/karabiner.json

#install-vim:
#	ln -sf `pwd`/.vimrc ~/.vimrc
#	vim +PluginInstall +qall

install-nvim:
	mkdir -p ~/.config
	ln -sf `pwd`/nvim ~/.config
	vim +PlugInstall

install-tmux:
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	ln -sf `pwd`/.tmux.conf ~/.tmux.conf

install-zsh:
	$(sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)")
	ln -sf `pwd`/.zshrc ~/.zshrc

install-lynx:
	ln -sf `pwd`/.lynxrc ~/.lynxrc

install-git:
	ln -sf `pwd`/.gitconfig ~/.gitconfig
	ln -sf `pwd`/.gitignore_global ~/.gitignore_global

install-newsboat:
	mkdir -p ~/.newsboat
	ln -sf `pwd`/.newsboat/urls ~/.newsboat/urls
	ln -sf `pwd`/.newsboat/config ~/.newsboat/config

clean: clean-karabiner \
    clean-vim \
    clean-tmux \
    clean-zsh \
    clean-lynx \
    clean-git \
    clean-newsboat

distclean: clean

clean-karabiner:
	rm -f ~/.config/karabiner/karabiner.json

clean-vim:
	rm -f ~/.vimrc

clean-tmux:
	rm -rf ~/.tmux/plugins/tpm
	rm -f ~/.tmux.conf

clean-zsh:
	rm -f ~/.zshrc

clean-lynx:
	rm -f ~/.lynxrc

clean-git:
	rm -f ~/.gitconfig
	rm -f ~/.gitignore_global

clean-newsboat:
	rm -f ~/.newsboat/config
	rm -f ~/.newsboat/urls
