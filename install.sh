#!/bin/sh
# git rm --cached install.sh && git add install.sh --chmod=+x

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "             cloning alias-tips                            "
    echo "-----------------------------------------------------------"
    git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
    echo "==========================================================="
    echo "             cloning zsh-syntax-highlighting               "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "==========================================================="
    echo "             cloning powerlevel10k                         "
    echo "-----------------------------------------------------------"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    sudo ln -fs $PWD/.zshrc $HOME/.zshrc
    echo "==========================================================="
    echo "             import powerlevel10k                          "
    echo "-----------------------------------------------------------"
    sudo ln -fs $PWD/.p10k.zsh $HOME/.p10k.zsh
}

# change time zone
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

zshrc

# make directly highlighting readable - needs to be after zshrc line
echo "" >> ~/.zshrc
echo "# remove ls and directory completion highlight color" >> ~/.zshrc
echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc

# fix permissions
sudo chmod -R g-s $HOME/.oh-my-zsh

# symlink to ddev homeadditions to they get copied into container
sudo ln -fs $HOME/.p10k.zsh $HOME/.ddev/homeadditions/.p10k.zsh
sudo ln -fs $HOME/.zshrc $HOME/.ddev/homeadditions/.zshrc
# sudo ln -fs $HOME/.gitconfig $HOME/.ddev/homeadditions/.gitconfig
sudo ln -fs $HOME/.bashrc $HOME/.ddev/homeadditions/.bashrc
sudo ln -fs $HOME/.oh-my-zsh $HOME/.ddev/homeadditions/
sudo ln -fs $HOME/config.local.yaml $HOME/.ddev/homeadditions/config.local.yaml

sudo chown -R codespace:codespace $HOME/.ddev/homeadditions

ddev restart
