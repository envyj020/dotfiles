# shellcheck disable=SC2148,SC1091,SC1090

# void on non-interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

shopt -s extglob
shopt -s dirspell
shopt -s histverify
shopt -s histappend
shopt -s checkwinsize

# Requires Bash >= v4
shopt -s cdspell 2>/dev/null || true
shopt -s autocd 2>/dev/null || true

[ -f /etc/bashrc ] && source /etc/bashrc

if [ -d "$HOME/.bashrc.d" ]; then
    for rc in "$HOME/.bashrc.d"/*; do
        source "$rc"
    done
fi

unset rc
