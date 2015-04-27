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
	rm -f $(HOME)/.inputrc

link:
	@ln -s $(shell pwd)/config/vim $(HOME)/.vim
	@ln -s $(shell pwd)/config/vimrc $(HOME)/.vimrc
	@ln -s $(shell pwd)/config/bashrc $(HOME)/.bashrc
	@ln -s $(shell pwd)/config/inputrc $(HOME)/.inputrc
	@echo "Everything is relinked!"

submodules:
	@git submodule init && git submodule update --init --recursive

ycm:
	@if [ -f $(shell pwd)/config/vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]; then \
		echo "YouCompleteMe is already compiled."; \
	else \
		@mkdir -p ycmbuild && cd ycmbuild && cmake -G "Unix Makefiles" . $(shell pwd)/config/vim/bundle/YouCompleteMe/third_party/ycmd/cpp && make ycm_support_libs -j$(shell grep -c ^processor /proc/cpuinfo); \
		rm -rf ycmbuild/; \
	fi
