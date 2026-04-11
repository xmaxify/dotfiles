#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
BRANCH="feat/brew-maintenance-$(date +%Y%m%d)"

echo "🍺 Updating Homebrew..."
brew update

echo "⬆️  Upgrading packages..."
brew upgrade --cask --greedy

echo "🧹 Cleaning up..."
brew cleanup

echo "📦 Dumping Brewfile..."
brew bundle dump --all --force --file="$DOTFILES_DIR/Brewfile_macos"

cd "$DOTFILES_DIR"

if git diff --quiet Brewfile_macos; then
  echo "✅ Brewfile bez zmian, nic do zrobienia."
  exit 0
fi

echo "🌿 Creating branch..."
git checkout -b "$BRANCH"
git add Brewfile_macos
git diff --cached --quiet || git commit -m "chore(brew): update Brewfile_macos $(date +%Y-%m-%d)"

echo "🚀 Pushing..."
git push -u origin "$BRANCH"

echo "🔀 Creating and merging MR..."
glab mr create --fill --squash-before-merge --remove-source-branch --yes
sleep 3
glab mr merge --squash --remove-source-branch --yes

echo "🔙 Switching back to main..."
git checkout main
git pull origin main

echo "🗑️  Deleting local branch..."
git branch -d "$BRANCH"

echo "✅ Done!"
