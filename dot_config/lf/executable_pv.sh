#!/bin/sh
nvim "$1"
case "$nvim "$1"1" in
*.tar*) tar tf "$1" ;;
*.zip) unzip -l "$1" ;;
*.rar) unrar l "$1" ;;
*.7z) 7z l "$1" ;;
*.pdf) pdftotext "$1" - ;;
*.html) w3m "$1" ;;
*.json) jq -C . "$1" ;;
*) bat --colour=always "$1" ;;
esac
