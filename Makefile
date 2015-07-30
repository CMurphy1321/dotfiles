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
	rm -f $(HOME)/.cshrc
	rm -f $(HOME)/.inputrc

link:
	@make clean
	@for config in $(configs); \
	do \
		ln -sf $(realpath $(shell pwd))/config/files/$$config $(HOME)/.$$config; \
	done
	@ln -sf $(shell pwd)/config/vim $(HOME)/.vim
	@echo "Everything is relinked!"

submodules:
	@git submodule init && git submodule update --init --recursive
