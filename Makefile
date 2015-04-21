all:
	rm -rf $(HOME)/.vim
	rm -f $(HOME)/.vimrc
	rm -f $(HOME)/.bashrc
	rm -f $(HOME)/.inputrc
	ln -s $(shell pwd)/config/vim $(HOME)/.vim
	ln -s $(shell pwd)/config/vimrc $(HOME)/.vimrc
	ln -s $(shell pwd)/config/bashrc $(HOME)/.bashrc
	ln -s $(shell pwd)/config/inputrc $(HOME)/.inputrc
	git submodule init && git submodule update
	git submodule update --init --recursive
	mkdir -p ycmbuild && cd ycmbuild && cmake -G "Unix Makefiles" . $(shell pwd)/config/vim/bundle/YouCompleteMe/third_party/ycmd/cpp && make ycm_support_libs -j6
	rm -rf ycmbuild/
	clear
	echo "All done! Enjoy :)"
