files := $(wildcard config/files/*)
configs := $(foreach config, $(files), $(notdir $(config)))

all:
	@make link
	@make submodules
	@make ycm
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
	@echo "Everything is relinked!"

submodules:
	@git submodule init && git submodule update --init --recursive

ycm:
	@if [ -f $(shell pwd)/config/vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]; then \
		echo "YouCompleteMe is already compiled."; \
	else \
		mkdir -p ycmbuild && cd ycmbuild && cmake -G "Unix Makefiles" . $(shell pwd)/config/vim/bundle/YouCompleteMe/third_party/ycmd/cpp && make ycm_support_libs -j$(shell grep -c ^processor /proc/cpuinfo); \
	fi
