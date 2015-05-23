all:
	@make clean
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

link:
	@make clean
	@ln -s $(shell pwd)/config/vim $(HOME)/.vim
	@ln -s $(shell pwd)/config/files/vimrc $(HOME)/.vimrc
	@ln -s $(shell pwd)/config/files/bashrc $(HOME)/.bashrc
	@ln -s $(shell pwd)/config/files/bash_profile $(HOME)/.bash_profile
	@ln -s $(shell pwd)/config/files/bash_prompt $(HOME)/.bash_prompt
	@ln -s $(shell pwd)/config/files/inputrc $(HOME)/.inputrc
	@echo "Everything is relinked!"

submodules:
	@git submodule init && git submodule update --init --recursive

ycm:
	@if [ -f $(shell pwd)/config/vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]; then \
		echo "YouCompleteMe is already compiled."; \
	else \
		mkdir -p ycmbuild && cd ycmbuild && cmake -G "Unix Makefiles" . $(shell pwd)/config/vim/bundle/YouCompleteMe/third_party/ycmd/cpp && make ycm_support_libs -j$(shell grep -c ^processor /proc/cpuinfo); \
		rm -rf ycmbuild/; \
	fi
