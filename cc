#!/bin/sh
echo "$1"
git add .
git commit -m "$1"
git push -u origin main