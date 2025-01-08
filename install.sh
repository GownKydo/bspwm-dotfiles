#!/bin/bash

function get_package_manager() {
    if command -v pacman &>/dev/null; then
        echo "pacman"
    elif command -v apt &>/dev/null; then
        echo "apt"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v zypper &>/dev/null; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

function check_dependencies() {
    echo -e "${yellowColour}[*] Checking dependencies in the system ...${endColour}\n"

    local packages=("bspwm" "sxhkd" "polybar" "rofi" "i3lock" "amixer" "zsh" "brightnessctl" \
                    "feh" "picom" "neofetch" "cowsay" "ranger" "alacritty" "lolcat" "htop" \
                    "flameshot" "lsd" "bat" "zsh")

    local successfully=0
    local failed=0
    local missing_dependencies=()
    local i=0

    for package in "${packages[@]}"; do
        if command -v "$package" &>/dev/null; then
            echo -e "\t${greenColour}[INSTALLED]${endColour} - ${package}."
            ((successfully++))
        else
            echo -e "\t${redColour}[NOT FOUND]${endColour} - ${package}."
            missing_dependencies[i]="${package}"
            ((failed++))
            ((i++))
        fi
        sleep 0.1
    done

    echo -e "\n${yellowColour} - $successfully packages found, $failed packages not found ${endColour}"

    if [ "$successfully" -ne 19 ]; then
        echo -e "${yellowColour}[*] Do you want to install the missing dependencies[y/n]? ${endColour}"
        read option

        if [[ $option =~ ^[Yy]$ ]]; then
            local pkg_manager=$(get_package_manager)

            case "$pkg_manager" in
                "pacman")
                    for dependencie in "${missing_dependencies[@]}"; do
                        pacman -S --noconfirm "${dependencie}"
                    done
                    ;;
                "apt")
                    for dependencie in "${missing_dependencies[@]}"; do
                        sudo apt install -y "$dependencie"
                    done
                    ;;
                "dnf")
                    for dependencie in "${missing_dependencies[@]}"; do
                        sudo dnf install -y "$dependencie"
                    done
                    ;;
                "zypper")
                    for dependencie in "${missing_dependencies[@]}"; do
                        sudo zypper install -y "$dependencie"
                    done
                    ;;
                *)
                    echo -e "${redColour}No compatible package manager found. Unable to install dependencies.${endColour}"
                    ;;
            esac
            echo -e "${yellowColour}\n[*] Dependencies correctly installed! ${endColour}\n\n"
        else 
            echo -e "${yellowColour}[*] Skipping installation of missing dependencies.${endColour}\n\n"
        fi
    fi
}

function check_and_handle_folders() {
    local base_dir=$(find "$HOME/" -depth -name dotfiles -type d -print -quit)
    local folders=("bspwm" "picom" "polybar" "neofetch" "rofi" "sxhkd")

    if [ ! -d "$HOME/.config/backup_config" ]; then
        echo -e "${yellowColour}[*] Creating backup config in ${greenColour}\"$HOME/.config/backup_config\" ${endColour}"
        mkdir -p "$HOME/.config/backup_config"
    fi

    for folder in "${folders[@]}"; do
        if [ -d $HOME/.config/$folder ]; then
            echo -e "${yellowColour}Moving ${folder} directory to ${greenColour}\"$HOME/config/backup_config\" ${endColour}"
            mv "$HOME/.config/$folder" "$HOME/.config/backup_config"
        fi
        sleep 0.2

        echo -e "${yellowColour}Coping config files ...${endColour}"
        cp -r "$base_dir/config/$folder" "$HOME/.config/"
        echo -e "\n"

        sleep 0.2
    done
}

function main() {
    # Clear Screen
    clear

    # Call Functions
    check_dependencies
    check_and_handle_folders
}

# Variables for colors
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
endColour="\033[0m\e[0m"

# Call the main function
main
