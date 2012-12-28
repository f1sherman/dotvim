Installation
============
```shell
git clone git@github.com:f1sherman/dotvim.git ~/.vim

cd ~/.vim

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# Create a directory at ~/.vimtmp for temp files
mkdir ~/.vimtmp

# Install submodules:
git submodule init
git submodule update

# Hook up pathogen:
ln -s ~/.vim/bundle/pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim

# Install command-t:
cd ~/.vim/bundle/command-t/
rvm use system
rake make

# Install ctags:
brew install ctags
```

Update
======
```shell
git pull origin master

# If any new plugins were added:
git submodule init
git submodule update
```

To add more plugins
===================
```shell
cd ~/.vim
git submodule add <repo url> bundle/<repo name>
add any additional/special instructions to this README
commit changes
```
