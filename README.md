# BSPWM and polybar configurations


This repository has been designed with the purpose of being able to set up a light and basic bspwm environment to learn how to start configuring one of your own and be adapted to your needs and tastes.


**Table of content**

* [Installation](#installation)
* [Screenshots](#screenshots)
* [keybinds](#keybinds)


## Installation

First we need to give run permissions to the _install.sh_ file and make sure you have the following packages installed on your system: [packages](#manual-installation)

```bash
chmod +x install.sh
```

After this we will execute the file and wait for the configuration to be done.

## Manual Installation

**Install following software**

* bspwm
* sxhkd
* polybar
* rofi
* i3lock
* amixer
* zsh
* brightnessctl
* feh 
* picom
* neofetch
* cowsay
* ranger
* alacrity
* lolcat

```bash
bspwm sxhkd polybar rofi i3lock amixer zsh brightnessctl feh picom neofetch cowsay ranger alacrity lolcat

```
<br>

## Screenshots

### Terminal

**neofetch, ranger, cowsay and nvchad**

![terminal](/screenshots/terminal.png)



### Polybar

The blue color in the polybar indicates that the window is occupied by some application, the white color indicates that it's empty and the pacman indicates in which window we are.

![polybar1](/screenshots/polybar1.png)

![polybar2](/screenshots/polybar2.png)

<br>

## keybinds

### Keysbinds for volume and Brightness

| **keybinds** | Command | **application** | 
|-|-|-|
| XF86MonBrightnessUp | brightnessctl set +10% | Brightness up |
| XF86MonBrightnessDown| brightnessctl set 10%- | Brightness down |
| XF86AudioRaiseVolume| amixer set Master 10%+ | Raises volume | 
| XF86AudioLowerVolume | amixer set Master 10%- | Lowers volume |
| XF86AudioMute | amixer -D pulse set Master 1+ toggle | Mute



### Launch applications

| **keybinds**  | **application** | 
|-|-|
| super + shift + b | brave-browser |
| super + shift + m | telegram desktop |
| Print | flameshot gui | 
| super + shift + o | obsidian |
| super + shift + v | Visual Studio Code


