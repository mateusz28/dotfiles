ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.cgdb ~/.cgdb
ln -s ~/dotfiles/.merger.sh ~/.merger.sh
ln -s ~/dotfiles/.diffwrap.sh ~/.diffwrap.sh
ln -s ~/dotfiles/.vifm ~/.vifm
#nvim rads vimrc 
mkdir -p ~/.config/nvim  
mkdir -p ~/.vim/colors
cp ~/dotfiles/init.vim  ~/.config/nvim/init.vim
cp ~/dotfiles/.vim/colors/lucius.vim  ~/.vim/colors/lucius.vim
[[ -f .ps_colors ]] || cp .ps_colors_template .ps_colors
[[ -f tmux-session-spectrum.conf ]] || cp tmux-session-spectrum-template.conf tmux-session-spectrum.conf
#install plug and vifm
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/mateusz28/tmux-session-spectrum.git  ~/.tmux/plugins/tmux-session-spectrum
~/.fzf/install
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
