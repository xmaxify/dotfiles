#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "🍺 Updating Homebrew..."
brew update

echo "⬆️  Upgrading packages..."
brew upgrade --cask --greedy

echo "🧹 Cleaning up..."
brew cleanup

echo "📦 Dumping Brewfile..."
brew bundle dump --all --force --file="$DOTFILES_DIR/Brewfile-macos"

echo "📝 Committing to git..."
cd "$DOTFILES_DIR"
git add Brewfile-macos
git diff --cached --quiet || git commit -m "chore: update Brewfile"
git push
