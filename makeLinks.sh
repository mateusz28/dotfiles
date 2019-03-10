ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.cgdb ~/.cgdb
ln -s ~/dotfiles/.merger.sh ~/.merger.sh
ln -s ~/dotfiles/.diffwrap.sh ~/.diffwrap.sh
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.vifm ~/.vifm
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.fzf/install
