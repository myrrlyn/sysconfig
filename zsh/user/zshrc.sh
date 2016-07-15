autoload -U colors && colors
autoload -Uz compinit && compinit
autoload -Uz vcs_info && vcs_info

# Powerline config?
if [[ -f $(which powerline) ]]; then
	powerline-daemon -q
	case $(uname -s) in
		Darwin)
			source /usr/local/lib/python*/site-packages/powerline/bindings/zsh/powerline.zsh
			;;
		Linux)
			source /usr/lib/python*/site-packages/powerline/bindings/zsh/powerline.zsh
			;;
	esac
fi

if [[ -h "${HOME}/.zaliases" ]]; then
	source ~/.zaliases
fi

# Set up VCS info hooks
#
# I have no idea how to get a reference to this exact file inside the script
# so this will only work once a symlink from home is established
if [[ -h "${HOME}/.zshrc" ]]; then
	source "$(dirname $(readlink "${HOME}/.zshrc"))/../../git/prompt.zsh"
	setup_vcs_git
fi

# Turn any string of /\.{2,}/ into the appropriate series of /\.\.\/{}\.\./
# The . key is reprogrammed to inspect the input buffer. If the input buffer
# already ends in two dots, pressing . again instead inserts "/.."
# Otherwise, pressing . just inserts an actual "." like it's supposed to.
function rationalise-dot() {
	if [[ ${LBUFFER} = *.. ]]; then
		LBUFFER+="/.."
	else
		LBUFFER+="."
	fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# Add hooks
autoload -U add-zsh-hook
# Execute functions on hook events
#            hook  handler function
add-zsh-hook chpwd chpwd_update_prompt
add-zsh-hook precmd precmd_update_prompt
add-zsh-hook preexec preexec_update_prompt

# These hook handlers all do the same thing -- update the prompt
function chpwd_update_prompt () {
	ps1_update
}

function precmd_update_prompt () {
	ps1_update
}

function preexec_update_prompt () {
	ps1_update
}

setopt prompt_subst

function ps1_update () {
	# Make an array of prompt parts. Each piece gets tacked on to the end, with
	# zsh automatically separating the elements by a space.
	local prompt_parts=()
	# User information: user@machine
	prompt_parts+="%F{${SZP_COL_USR:-yellow}}%n%f@%F{${SZP_COL_USR:-yellow}}%m%f"

	# SSH connection?
	if [[ ! -z $SSH_CONNECTION ]]; then
		prompt_parts+="%F{${SZP_COL_SSH:-blue}}(SSH)%f"
	fi

	# Current working directory, with ~ swapped in for $HOME if applicable
	prompt_parts+="%F{${SZP_COL_DIR:-cyan}}%~%f"

	# TODO: put git and RVM shell customizations in their respective configs,
	# and expose them to this function for use.

	# If we're not in a git project
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]]; then
		prompt_parts+="%F{${SZP_COL_VCS:-magenta}}${vcs_info_msg_0_}%f"
	fi

	# RVM information
	if [[ ! -z ${rvm_path} ]]; then
		if [[ -f "${rvm_path}/bin/rvm-prompt" ]] ; then
			prompt_parts+="%F{red}$(${rvm_path}/bin/rvm-prompt)%f"
		fi
	fi

	# For obvious reasons, the sigil goes LAST
	prompt_parts+="
%F{${SZP_COL_USR:-yellow}}λ%f "

	export PROMPT=$(print ${prompt_parts})
}

export RPROMPT="%F{%(?.green.red)}%?%f"
