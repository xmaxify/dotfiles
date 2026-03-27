# source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

export PATH="$HOME/.local/bin:$PATH"

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' list-prompt '%S%M: %p%u'
zstyle ':completion:*' completer _complete _ignored _files _command

bindkey '^I' expand-or-complete-prefix
# bindkey -M viins v vi-visual


#if type brew &>/dev/null; then
#  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#  autoload -Uz compinit
#  compinit
#fi
# ~/.zshrc
export GITLAB_TOKEN=$(security find-generic-password -a "$USER" -s "gitlab_token_work" -w 2>/dev/null)
gitlab-init-envrc() {
  if [ -f .envrc ]; then
    echo "⚠️  .envrc już istnieje"
    return 1
  fi

  echo 'export GITLAB_TOKEN=$(security find-generic-password -a "$USER" -s "gitlab_token" -w 2>/dev/null)' > .envrc
  direnv allow
  echo "✅ .envrc created with personal GitLab token"
}
eval "$(direnv hook zsh)"
