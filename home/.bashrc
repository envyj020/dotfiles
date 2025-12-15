# vim: set ft=sh:
# skip on non-interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

shopt -s extglob
shopt -s dirspell
shopt -s histverify
shopt -s histappend
shopt -s checkwinsize

# requires bash >= v4
shopt -s cdspell 2>/dev/null || true
shopt -s autocd 2>/dev/null || true

[ -f /etc/bashrc ] && source /etc/bashrc

if [ -d "$HOME/.bashrc.d" ]; then
    for rc in "$HOME/.bashrc.d"/*; do
        # shellcheck source=/dev/null
        source "$rc"
    done
fi

unset rc
