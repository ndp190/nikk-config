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
	# install neovim plugin
	nvim +PlugInstall +qall
	# install coc plugins
	# nvim '+CocInstall -sync coc-phpls coc-python coc-tsserver coc-prettier coc-go' +qall
	# install lsp plugins
	nvim "+call lspinstall#install_server('go') | call lspinstall#install_server('yaml') | call lspinstall#install_server('bash') | call lspinstall#install_server('php') | call lspinstall#install_server('typescript') | call lspinstall#install_server('terraform')"
	nvim '+TSInstall php typescript bash javascript go yaml python'
	# install ranger icon
	git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
	ln -sf `pwd`/rifle.conf ~/.config/ranger/rifle.conf
	echo "default_linemode devicons" >> ~/.config/ranger/rc.conf
	echo "map <DELETE> shell -s trash-put %s" >> ~/.config/ranger/rc.conf
	echo "set show_hidden true" >> ~/.config/ranger/rc.conf

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
