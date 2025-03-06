# BSPWM and polybar configurations


This repository has been designed with the purpose of being able to set up a light and basic bspwm environment to learn how to start configuring one of your own and be adapted to your needs and tastes.


**Table of content**

* [Installation](#installation)
* [Muanal Installation](#manual-installation)
* [Screenshots](#screenshots)
* [keybinds](#keybinds)


## Installation

First we need to give run permissions to the _install.sh_ file and execute. 

```bash
cd ~/Desktop
git clone https://github.com/GownKydo/dotfiles.git
cd dotfiles
chmod +x install.sh &&./install.sh

```

After this we will execute the file and logout of the session.


## Manual Installation

**Install following software**

| **Arch**  | **Debian** | 
|-|-|
| bspwm | bspwm
| sxhkd | sxhkd
| polybar | polybar
| rofi | rofi
| i3lock | i3lock
| pamixer | amixer
| zsh | zsh 
| brightnessctl | brightnessctl
| feh | feh 
| picom | picom
| neofetch | neofetch
| cowsay | cowsay
| ranger | ranger
| alacritty | alacritty
| lolcat | lolcat
| htop | htop
| flameshot | flameshot

```bash
bspwm sxhkd polybar rofi i3lock pamixer zsh brightnessctl feh picom neofetch cowsay ranger alacritty lolcat htop flameshot

```
### Install p10k for zsh

To use this theme for zsh, run the following command to perform the manual installation and continue:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```
Before running this command to change the shell:

```bash
chsh --shell /usr/bin/zsh username
```

> Install the "JetBrainsMono Nerd Fonts" from 
this site: [Hack Nerd Fonts](https://www.nerdfonts.com/font-downloads) (these are used for icons in the polybar).

<br>

## Screenshots

### Desktop

**neofetch, htop, ranger, cowsay with lolcat and nvchad**

![Desktop](/screenshots/desktop.png)

**Brave, obsidian and bat**
![Desktop](/screenshots/desktop2.png)


### Polybar

The blue color in the polybar indicates that the window is occupied by some application, the gray color indicates that it's empty and the pacman indicates in which window we are.

![polybar1](/screenshots/polybar1.png)

![polybar2](/screenshots/polybar2.png)

<br>

## keybinds

### Volume and Brightness

Command | **application** | 
|-|-|
| brightnessctl set +10% | Brightness up |
| brightnessctl set 10%- | Brightness down |
| amixer set Master 10%+ | Raises volume | 
| amixer set Master 10%- | Lowers volume |
| amixer -D pulse set Master 1+ toggle | Mute



### Launch applications

| **keybinds**  | **application** | 
|-|-|
| super + d | rofi |
| super + w | close window |
| super + enter | terminal alacritty | 
| super + shift + b | brave-browser |
| super + shift + m | telegram desktop |
| Print | flameshot gui | 
| super + shift + o | obsidian |
| super + shift + v | Visual Studio Code

<br>

> Modify the file `.config/sxhkd/sxhkdrc` for add o change shortcuts
