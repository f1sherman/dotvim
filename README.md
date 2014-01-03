Installation
============
```shell
git clone git@github.com:f1sherman/dotvim.git ~/.vim

cd ~/.vim

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# Create a directory at ~/.vimtmp for temp files
mkdir ~/.vimtmp

# Install vundle:
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

# Install command-t:
cd ~/.vim/bundle/command-t/
rake make

# Install ctags:
brew install ctags

# Install YouCompleteMe (autocompletion) - see 'super quick installation' notes here: https://github.com/Valloric/YouCompleteMe
```

Update
======
```shell
git pull origin master

# If any new plugins were added:
vim +BundleInstall +qall
```

To add more plugins
===================
```shell
# Add 'Bundle' line to vimrc as specified here: https://github.com/gmarik/vundle
vim +BundleInstall +qall
add any additional/special instructions to this README
commit changes
```
