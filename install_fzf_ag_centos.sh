#!/bin/bash

sudo yum install -y the_silver_searcher && \

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
~/.fzf/install
