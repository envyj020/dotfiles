# vim: set ft=sh:

readonly EXPORTS_FILE="$HOME/.bashrc.d/00-EXPORTS"

# shellcheck source=/dev/null
[ -s "$EXPORTS_FILE" ] && source "$EXPORTS_FILE"
