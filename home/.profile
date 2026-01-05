# vim: set ft=sh:

readonly BASH_EXPORTS="$HOME/.bashrc.d/00-EXPORTS"

# shellcheck source=/dev/null
[ -s "$BASH_EXPORTS" ] && source "$BASH_EXPORTS"
