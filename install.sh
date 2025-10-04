#!/bin/bash

# Variables for colors
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
endColour="\033[0m\e[0m"

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
                    "feh" "picom" "fastfetch" "cowsay" "ranger" "alacritty" "lolcat" "htop" \
                    "flameshot" "lsd" "bat")

    local successfully=0
    local failed=0
    local missing_dependencies=()

    for package in "${packages[@]}"; do
        if command -v "$package" &>/dev/null; then
            echo -e "\t${greenColour}[INSTALLED]${endColour} - ${package}."
            ((successfully++))
        else
            echo -e "\t${redColour}[NOT FOUND]${endColour} - ${package}."
            missing_dependencies+=("$package")
            ((failed++))
        fi
        sleep 0.1
    done

    echo -e "\n${yellowColour} - $successfully packages found, $failed packages not found ${endColour}"

    if [ "$successfully" -ne 19 ]; then
        echo -e "${yellowColour}[*] Do you want to install the missing dependencies[y/n]? ${endColour}"
        read option

        if [[ $option =~ ^[Yy]$ ]]; then
            # Check if the user is root
            if [ "$(id -u)" -ne 0 ]; then
                echo -e "${redColour}This script must be run as root. Exiting...${endColour}"
                exit 1
            fi
            
            local pkg_manager=$(get_package_manager)
            local band=true
            
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
                    band=false
                    echo -e "${redColour}No compatible package manager found. Unable to install dependencies.${endColour}"
                    ;;
            esac
            if [[ $band ]]; then
                echo -e "${yellowColour}\n[*] Dependencies correctly installed! ${endColour}\n\n"
            fi
        fi
    fi
}

function check_and_handle_folders() {
    local base_dir=$(find "$HOME/" -depth -name bspwm-dotfiles -type d -print -quit)
    if [ -z "$base_dir" ]; then
        echo -e "${redColour}[!] Dotfiles directory not found. Exiting...${endColour}"
        exit 1
    fi

    local folders=("bspwm" "picom" "polybar" "fastfetch" "rofi" "sxhkd")

    if [ ! -d "$HOME/.config/backup_config" ]; then
        echo -e "${yellowColour}[*] Creating backup config in ${greenColour}\"$HOME/.config/backup_config\" ${endColour}"
        mkdir -p "$HOME/.config/backup_config"
    fi

    for folder in "${folders[@]}"; do
        if [ -d "$HOME/.config/$folder" ]; then
            echo -e "${yellowColour}Moving ${folder} directory to ${greenColour}\"$HOME/.config/backup_config\" ${endColour}"
            mv "$HOME/.config/$folder" "$HOME/.config/backup_config"
        fi
        sleep 0.2

        echo -e "${yellowColour}Copying config files ...${endColour}"

        if [ -n "$base_dir" ] && [ -d "$base_dir/config/$folder" ]; then
            cp -r "$base_dir/config/$folder/" "$HOME/.config/"
        else
            echo -e "${redColour}Source directory for $folder not found.${endColour}"
            echo -e "${yellowColour}Generating directory and copying files...${endColour}"

            mkdir -p "$HOME/.config/$folder"
            if [ -d "./config/$folder" ]; then
                cp -r "./config/$folder/." "$HOME/.config/$folder/"
            fi
        fi
        echo -e "\n"
    done
}

function main() {
    # Clear Screen
    clear

    # Call Functions
    check_dependencies
    check_and_handle_folders
}

# Call the main function
main
