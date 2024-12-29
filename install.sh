#!/bin/bash

greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
endColour="\033[0m\e[0m"

function check_dependencies() {
    echo -e "${yellowColour}[*] Cheking dependencies in the system ...${endColour}\n"

    local packages=("bspwm" "sxhkd" "polybar" "rofi" "i3lock" "amixer" "zsh" "brightnessctl" \
                    "feh" "picom" "neofetch" "cowsay" "ranger" "alacritty" "lolcat")

    for package in "${packages[@]}"; do
        if command -v "$package" &>/dev/null; then
            echo -e "${greenColour}[INSTALLED] - ${endColour} ${package}"
        else
            echo -e "${redColour}[NOT FOUND] - ${endColour} $package. Please install the package."
        fi
        sleep 0.5
    done

    echo -e "\n ${yellowColour}The verification of the packages has been successfully completed!${endColour} \n"
}

function check_and_handle_folders() {
    local base_dir=$(find $HOME/ -depth -name dotfiles -type d -print -quit)
    local folders=("bspwm" "nvim" "picom" "polybar" "rofi" "sxhkd")
    
    mkdir -p /home/$USER/.config/backup_config

    for folder in "${folders[@]}"; do        
        if [ -d $HOME/.config/$folder ]; then
            mv $HOME/.config/$folder $HOME/.config/backup_config
        fi

        mkdir $HOME/.config/$folder
        cp -r "$base_dir/config/$folder" "$HOME/.config/$folder"
    done
}

clear
check_dependencies
check_and_handle_folders
