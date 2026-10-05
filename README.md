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

## Clipboard in Herdr

Neovim sends copies from the `+` and `*` registers to the local clipboard
through OSC 52. Herdr does not answer OSC 52 clipboard read requests.
Register previews and register paste use the last value copied to each
register in the current Neovim session. They do not read the system clipboard.
Use the terminal paste command to insert new text from the system clipboard.
Nested tmux keeps its automatic clipboard provider.

Run `bash tests/clipboard-provider.sh` to check clipboard writes, register
reads, and nested tmux provider selection.

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
