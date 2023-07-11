# dotfiles

## Introduction

This repository serves as my way to help me setup and maintain my 2017 27" iMac and my two macBook Airs. It takes the effort out of installing everything manually. Almost everything needed to install my preferred setup of macOS is detailed in this readme.

I use Chezmoi for my dotfile management and Mackup for application preferences. I still need to work out how to handle .macOS preferences.

## A Fresh macOS Setup

These instructions are for setting up new Mac devices.

### Setting up your Mac

After backing up your old Mac you may now follow these install instructions to setup a new one.

1. Update macOS to the latest version through system preferences

2. Initialise Chezmoi on my new Mac

  ```
  chezmoi init apply akladnig
  ```
3. Run the installation with:

  ```
  zsh ./install.sh
  ```
4. After mackup is synced with your cloud storage, restore preferences by running `mackup restore`
5. Restart your computer to finalize the process

Your Mac is now ready to use!