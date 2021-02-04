curl https://rclone.org/install.sh > install.sh
chmod +x install.sh
sudo install.sh
rm install.sh
echo "Paste config file"
mkdir -p $HOME/.config/rclone/
nvim $HOME/.config/rclone/rclone.conf
