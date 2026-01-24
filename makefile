#Detect OS
UNAME := $(shell uname)

# Build based on OS name
DetectOS:
	-@make $(UNAME)

# Mac OS
Darwin: prerequisite \
    install-custom-script \
    install-karabiner \
	install-aerospace \
    install-nvim \
    install-tmux \
    install-zsh \
    install-git \
    install-wezterm \
	install-taskwarrior \
	install-claude

Linux: prerequisite-linux \
    install-nvim \
    install-zsh \
    install-git

prerequisite:
	chmod +x `pwd`/install-brew.sh `pwd`/install-node.sh `pwd`/install-pip.sh
	`pwd`/install-brew.sh
	`pwd`/install-node.sh
	`pwd`/install-pip.sh

prerequisite-linux:
	chmod +x `pwd`/install-apt-get.sh
	`pwd`/install-apt-get.sh

install-custom-script:
	sudo mkdir -p /usr/local/bin
	chmod +x `pwd`/custom-script/autogen-pyinit.sh `pwd`/custom-script/echo-colorized.sh `pwd`/custom-script/music-animation.sh
	sudo ln -sf `pwd`/custom-script/autogen-pyinit.sh /usr/local/bin/autogen-pyinit
	sudo ln -sf `pwd`/custom-script/echo-colorized.sh /usr/local/bin/echo-colorized
	sudo ln -sf `pwd`/custom-script/lazy-nvm.sh /usr/local/bin/lazy-nvm.sh
	mkdir -p ~/.config/tmux
	ln -sf `pwd`/custom-script/music-animation.sh ~/.config/tmux/music-animation.sh

install-karabiner:
	mkdir -p ~/.config/karabiner
	ln -sf `pwd`/karabiner.json ~/.config/karabiner/karabiner.json

install-aerospace:
	ln -sf `pwd`/.aerospace.toml ~/.aerospace.toml

install-nvim:
	mkdir -p ~/.config
	ln -sf `pwd`/nvim ~/.config

install-zellij:
	mkdir -p ~/.config/zellij
	ln -sf `pwd`/zellij/config.kdl ~/.config/zellij/config.kdl
	ln -sf `pwd`/zellij/go1-layout.kdl ~/.config/zellij/go1-layout.kdl
	ln -sf `pwd`/zellij/side-layout.kdl ~/.config/zellij/side-layout.kdl

install-tmux:
	mkdir -p ~/.tmux/plugins
	if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; fi
	ln -sf `pwd`/.tmux.conf ~/.tmux.conf

install-zsh:
	$(sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)")
	ln -sf `pwd`/.zshrc ~/.zshrc
	if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions; fi
	if [ ! -f "${HOME}/.zsh_custom.zsh" ]; then cp `pwd`/.zsh_custom.zsh.example ~/.zsh_custom.zsh; fi

install-git:
	ln -sf `pwd`/.gitconfig ~/.gitconfig
	ln -sf `pwd`/.gitignore_global ~/.gitignore_global
	if [ ! -f "${HOME}/.gitconfig_go1" ]; then cp `pwd`/.gitconfig_go1.example ~/.gitconfig_go1; fi
	if [ ! -f "${HOME}/.gitconfig_github" ]; then cp `pwd`/.gitconfig_github.example ~/.gitconfig_github; fi

install-alacritty:
	ln -sf `pwd`/.alacritty.yml ~/.alacritty.yml

install-wezterm:
	ln -sf `pwd`/.wezterm.lua ~/.wezterm.lua

install-taskwarrior:
	ln -sf `pwd`/.taskrc ~/.taskrc

install-claude:
	mkdir -p ~/.claude/scripts
	chmod +x `pwd`/claude/scripts/context-bar.sh
	ln -sf `pwd`/claude/scripts/context-bar.sh ~/.claude/scripts/context-bar.sh

clean: clean-karabiner \
    clean-vim \
    clean-tmux \
    clean-zsh \
    clean-lynx \
    clean-git \
    clean-newsboat \
    clean-claude

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

clean-claude:
	rm -f ~/.claude/scripts/context-bar.sh
