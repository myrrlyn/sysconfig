autoload -U colors && colors
#autoload -Uz compinit && compinit
#autoload -Uz vcs_info

# Set the primary prompt to show user@host, the PWD, and a lambda or omega
PROMPT="%F{%(!.red.green)}%n%f@%F{%(!.red.green)}%m%f %F{cyan}%~%f
%F{%(!.red.green)}%(!.Ω.λ)%f "

# Set the right prompt to be the previous command's exit code
RPROMPT="%F{%(?.green.red)}%?%f"

# Source system zsh plugins
case $(uname -s) in
	Darwin)
		local prefix="/usr/local/share"
	;;
	Linux)
		local prefix="/usr/share/zsh/plugins"
	;;
esac
for file in $(\ls ${prefix}/zsh-*/zsh-*.zsh); do
	source ${file}
done
