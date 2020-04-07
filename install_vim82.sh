#!/bin/bash

sudo yum remove -y vim-enhanced vim-common vim-filesystem

mkdir -p ~/install && cd ~/install
sudo yum install -y bash-completion git && \
sudo yum install -y gcc make ncurses ncurses-devel && \
sudo yum install -y ctags git tcl-devel ruby ruby-devel lua lua-devel luajit luajit-devel python python-devel perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed

sudo yum install -y yum-utils && \
sudo yum-builddep vim-X11

wget ftp://ftp.vim.org/pub/vim/unix/vim-8.2.tar.bz2 && \
sudo yum install -y lbzip2 && sudo tar -xf vim-8.2.tar.bz2

cd vim82

sudo ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-cscope \
            --enable-gui=auto \
            --enable-gtk2-check \
            --with-x && \
sudo make && \
sudo make install && \
vim --version
