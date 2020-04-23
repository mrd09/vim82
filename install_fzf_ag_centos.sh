#!/bin/bash

sudo yum install -y the_silver_searcher && \

git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1 && \

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
~/.fzf/install
