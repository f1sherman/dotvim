Installation
============
```shell
git clone git@github.com:f1sherman/dotvim.git ~/.vim

cd ~/.vim

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# Create a directory at ~/.vimtmp for temp files
mkdir ~/.vimtmp

# Clone vundle:
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install vundle
vim +PluginInstall +qall
```

Update
======
```shell
git pull origin master

# If any new plugins were added (can use PluginInstall! to also update existing plugins):
vim +PluginInstall
```

To add more plugins
===================
```shell
# Add 'Bundle' line to vimrc as specified here: https://github.com/gmarik/vundle
vim +PluginInstall +qall
add any additional/special instructions to this README
commit changes
```
