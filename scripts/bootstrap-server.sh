#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="https://github.com/xmaxify/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"
NVIM_TARBALL_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
LOCAL_BIN="$HOME/.local/bin"

log() { echo "[bootstrap] $*"; }

# --- nvim ---
install_nvim() {
  if command -v nvim &>/dev/null; then
    local version
    version=$(nvim --version | head -1 | grep -oP '\d+\.\d+' | head -1)
    local major minor
    major=$(echo "$version" | cut -d. -f1)
    minor=$(echo "$version" | cut -d. -f2)
    if [[ "$major" -ge 1 ]] || [[ "$major" -eq 0 && "$minor" -ge 9 ]]; then
      log "nvim $(nvim --version | head -1) already installed, skipping"
      return
    fi
    log "nvim version too old, installing newer"
  fi

  log "Installing nvim tarball..."
  mkdir -p "$LOCAL_BIN"
  curl -fsSL "$NVIM_TARBALL_URL" -o /tmp/nvim-linux-x86_64.tar.gz
  tar -xzf /tmp/nvim-linux-x86_64.tar.gz -C "$LOCAL_BIN"
  rm -f /tmp/nvim-linux-x86_64.tar.gz
  ln -sf "$LOCAL_BIN/nvim-linux-x86_64/bin/nvim" "$LOCAL_BIN/nvim"

  log "nvim installed: $($LOCAL_BIN/nvim --version | head -1)"
}

# --- ripgrep ---
install_ripgrep() {
  if command -v rg &>/dev/null; then
    log "ripgrep $(rg --version | head -1) already installed, skipping"
    return
  fi

  log "Installing ripgrep..."
  local rg_version
  rg_version=$(curl -fsSL https://api.github.com/repos/BurntSushi/ripgrep/releases/latest |
    grep -oP '"tag_name": "\K[^"]+')

  local rg_tarball="ripgrep-${rg_version}-x86_64-unknown-linux-musl.tar.gz"
  curl -fsSL "https://github.com/BurntSushi/ripgrep/releases/download/${rg_version}/${rg_tarball}" \
    -o "/tmp/${rg_tarball}"

  mkdir -p "$LOCAL_BIN"
  tar -xzf "/tmp/${rg_tarball}" -C /tmp
  cp "/tmp/ripgrep-${rg_version}-x86_64-unknown-linux-musl/rg" "$LOCAL_BIN/rg"
  chmod +x "$LOCAL_BIN/rg"
  rm -rf "/tmp/${rg_tarball}" "/tmp/ripgrep-${rg_version}-x86_64-unknown-linux-musl"

  log "ripgrep installed: $($LOCAL_BIN/rg --version | head -1)"
}

# --- dotfiles ---
setup_dotfiles() {
  if [[ -d "$DOTFILES_DIR/.git" ]]; then
    log "Updating dotfiles..."
    git -C "$DOTFILES_DIR" pull --quiet
  else
    log "Cloning dotfiles..."
    git clone --quiet "$DOTFILES_REPO" "$DOTFILES_DIR"
  fi
}

# --- stow ---
setup_stow() {
  if ! command -v stow &>/dev/null; then
    log "WARNING: stow not found — symlinking manually"
    mkdir -p "$HOME/.config"
    ln -sfn "$DOTFILES_DIR/nvim-server/.config/nvim-server" "$HOME/.config/nvim-server"
    return
  fi

  log "Stowing nvim-server config..."
  stow --dir="$DOTFILES_DIR" --target="$HOME" nvim-server
}

# --- PATH ---
ensure_path() {
  if [[ ":$PATH:" != *":$LOCAL_BIN:"* ]]; then
    log "Adding $LOCAL_BIN to PATH for this session"
    export PATH="$LOCAL_BIN:$PATH"
  fi

  local shell_rc
  shell_rc="$HOME/.bashrc"
  [[ -n "${ZSH_VERSION:-}" ]] && shell_rc="$HOME/.zshrc"

  if ! grep -q "$LOCAL_BIN" "$shell_rc" 2>/dev/null; then
    echo "export PATH=\"$LOCAL_BIN:\$PATH\"" >>"$shell_rc"
    log "Added $LOCAL_BIN to $shell_rc"
  fi
}

# --- alias ---
setup_alias() {
  local shell_rc
  shell_rc="$HOME/.bashrc"
  [[ -n "${ZSH_VERSION:-}" ]] && shell_rc="$HOME/.zshrc"

  local alias_line='alias v="NVIM_APPNAME=nvim-server nvim"'
  if ! grep -qF "$alias_line" "$shell_rc" 2>/dev/null; then
    echo "$alias_line" >>"$shell_rc"
    log "Added alias 'v' to $shell_rc"
  fi
}

install_nvim
install_ripgrep
setup_dotfiles
setup_stow
ensure_path
setup_alias

log "Done. Run: NVIM_APPNAME=nvim-server nvim (or just 'v' in a new shell)"

