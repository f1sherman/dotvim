# Brian's vim config

## Installation

```shell
git clone git@github.com:f1sherman/dotvim.git ~/.vim

cd ~/.vim

ln -s ~/.vim/vimrc ~/.vimrc

# Create a directory at ~/.vimtmp for temp files
mkdir ~/.vimtmp

# Start nvim to install vim-plug and plugins
nvim

# Quit nvim and Install YouCompleteMe
~/.vim/plugged/YouCompleteMe/install.py
```

## Update

```shell
git pull origin main

# If any new plugins were added:
nvim +PlugUpdate
```

## To add more plugins

```shell
# Add 'Plug' line to vimrc (see existing vimrc for examples)
nvim +PlugUpdate +qall
add any additional/special instructions to this README
commit changes
```
