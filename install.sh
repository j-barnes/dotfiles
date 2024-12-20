#!/bin/sh
# git rm --cached install.sh && git add install.sh --chmod=+x

zshrc() {
    echo "==========================================================="
    echo "             installing .oh-my-zsh                         "
    echo "-----------------------------------------------------------"
    git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    cat .zshrc > $HOME/.zshrc
    echo "==========================================================="
    echo "             import powerlevel10k                          "
    echo "-----------------------------------------------------------"
    cat .p10k.zsh > $HOME/.p10k.zsh
    echo "==========================================================="
    echo "             import bashrc                                 "
    echo "-----------------------------------------------------------"
    cat .bashrc > $HOME/.bashrc
    echo "==========================================================="
    echo "             import gitconfig                              "
    echo "-----------------------------------------------------------"
    cat .gitconfig > $HOME/.gitconfig
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
    if [ -d "$HOME/.ddev/homeadditions" ]
    then
        echo "==========================================================="
        echo "             adding .dotfiles to homeadditions             "
        echo "-----------------------------------------------------------"
        cat .gitconfig > $HOME/.ddev/homeadditions/.gitconfig
        cat .bashrc > $HOME/.ddev/homeadditions/.bashrc
        cat .p10k.zsh > $HOME/.ddev/homeadditions/.p10k.zsh
        cat .zshrc > $HOME/.ddev/homeadditions/.zshrc
        cp -Lr $HOME/.oh-my-zsh $HOME/.ddev/homeadditions
    fi
}

zshrc
