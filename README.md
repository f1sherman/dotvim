# Brian's vim config

## Installation

```shell
git clone git@github.com:f1sherman/dotvim.git ~/.vim

cd ~/.vim

ln -s ~/.vim/vimrc ~/.vimrc

# Create a directory at ~/.vimtmp for temp files
mkdir ~/.vimtmp

# Start vim to install vim-plug and plugins
vim

# Quit vim and Install YouCompleteMe
~/.vim/plugged/YouCompleteMe/install.py
```

## Update

```shell
git pull origin master

# If any new plugins were added:
vim +PlugUpdate
```

## To add more plugins

```shell
# Add 'Plug' line to vimrc (see existing vimrc for examples)
vim +PlugUpdate +qall
add any additional/special instructions to this README
commit changes
```
