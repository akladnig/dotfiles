#!/bin/sh

echo "Setting up your Mac..."

# Install Rosetta 2
sudo softwareupdate --install-rosetta

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
	/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Check for Chezmoi and install if we don't have it

if test ! $(which chezmoi); then
	brew install chezmoi
fi
chezmoi init --apply akladnig

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./dotfiles/Brewfile

#install cocoapods
sudo gem install cocoapods

#install bash LSP
npm i -g bash-language-server

#install go LSP
go install golang.org/x/tools/gopls@latest          # LSP
go install github.com/go-delve/delve/cmd/dlv@latest # Debugger
go install golang.org/x/tools/cmd/goimports@latest  # Formatter

# Set macOS preferences - we will run this last because this will reload the shell

# source ./.macos
