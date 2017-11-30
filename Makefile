files := $(wildcard config/files/*)
configs := $(foreach config, $(files), $(notdir $(config)))

all:
	@make link
	@make submodules
	@clear
	@echo "All done! Enjoy :)"

clean:
	rm -rf $(HOME)/.vim
	rm -f $(HOME)/.vimrc
	rm -f $(HOME)/.bashrc
	rm -f $(HOME)/.bash_prompt
	rm -f $(HOME)/.bash_profile
	rm -f $(HOME)/.inputrc
	rm -f $(HOME)/.gitconfig

link:
	@make clean
	@for config in $(configs); \
	do \
		ln -sf $(realpath $(shell pwd))/config/files/$$config $(HOME)/.$$config; \
	done
	@ln -sf $(shell pwd)/config/vim $(HOME)/.vim
	@mkdir -p $(HOME)/.config/nvim
	@ln -sf $(shell pwd)/config/files/init.vim $(HOME)/.config/nvim/init.vim
	@echo "Everything is relinked!"

submodules:
	@git submodule init && git submodule update --init --recursive
