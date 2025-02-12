export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export PAGER="nvim +Man!"
export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

eval "$(/opt/homebrew/bin/brew shellenv)"

source ~/.orbstack/shell/init.zsh 2>/dev/null || :
