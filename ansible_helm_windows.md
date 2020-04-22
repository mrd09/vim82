# presiquite:
- download oc client windows and first login
    + set path to oc.exe
    + set oc_bash_completion
- download helm client windows and plugin install: `helm plugin install https://github.com/rimusz/helm-tiller`

# Cygwin install
https://geekflare.com/ansible-installation-windows/
https://codecute.com/c/cygwin-la-gi-cai-dat-compiler-c-c-cygwin-tren-windows.html

##  Set path cygwin:
- set path windows: C:\cygwin64\bin

##  Pkg install:
ansible, vim, fzf, the_silver_search, wget, curl, git, procps

- if finish install re run the setup-x86_64.exe to install new pkg:

##  Install pip:
python3.7 -m ensurepip
pip3 install ansible-modules-hashivault

##  chere: open-cygwin-at-a-specific-folder
https://stackoverflow.com/questions/9637601/open-cygwin-at-a-specific-folder

- After Cygwin is launched, open up a Cygwin terminal (as an administrator) and type the command: 
```
chere -i -t mintty -s bash
```

- Now you should have "Bash Prompt Here" in the Windows right-click context menu.

##  helm
- binary command: copy `helm.exe and tiller.exe` from `G:\true\helm_2.16.6\windows-amd64` to `C:\cygwin64\bin`

- ~/.bashrc
```
alias tillerless='/cygdrive/g/true/helm_2.16.6/helm_tillerless_scripts/tiller.sh'
```
- vim `/cygdrive/g/true/helm_2.16.6/helm_tillerless_scripts/tiller.sh`
```
:%s/\.\/bin\/tiller/tiller/gc
```
    + then modify:
```
    # check if the tiller binary exists
    if [ ! -f /usr/bin/tiller ]; then
```

- set env windows:
```
HELM_TILLER_HISTORY_MAX=8
HELM_TILLER_STORAGE=configmap
```

- test:
```
tillerless run my-name-space -- helm list
```

# bash-git-prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

- make change `C:\Program Files\Git\etc\profile.d\aliases.sh`
```
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi
```


# vim82 config git clone:
 git clone --recursive git@github.com:mrd09/vim82.git ~/.vim

# alias:
```
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

alias gb='git checkout -'
alias gmt='git mergetool --tool=vimdiff'
alias gca='git commit --amend'
alias gcp='git cherry-pick'
alias glf='git log --follow -p'
alias gl='git log --oneline -10'
alias gpf='git push -u --force-with-lease'
alias gst='git status'
alias gf='git fetch'

alias tillerless='/cygdrive/g/true/helm_2.16.6/helm_tillerless_scripts/tiller.sh'
```