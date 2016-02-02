# System zsh rc file.

autoload -U colors && colors
#autoload -Uz compinit && compinit
#autoload -Uz vcs_info

PROMPT="%F{%(!.red.yellow)}%n%f@%F{%(!.red.yellow)}%m%f %F{blue}%~%f
%F{%(!.red.yellow)}%(!.Ω.λ)%f "

RPROMPT="%F{%(?.green.red)}%?%f"

configs=()
configs+="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
for FILE in configs ; do
	[[ -f $FILE ]] && source $FILE
done

# If tmux exists, alias it to use -2u by default because for some reason, using
# the configuration file to do that just isn't working out nicely.
[[ "$(which \tmux)" ]] && alias tmux="tmux -2u"
