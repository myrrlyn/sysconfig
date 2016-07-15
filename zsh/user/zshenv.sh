# I haaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaate the typical editors
[[ -f "$(which nano)" ]] && export EDITOR="$(which nano)"
[[ -f "$(which atom)" ]] && export VISUAL="$(which atom) --wait"

typeset -U path
[[ -d "${HOME}/bin" ]] && path+="${HOME}/bin"
