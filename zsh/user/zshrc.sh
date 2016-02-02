autoload -U colors && colors
autoload -Uz compinit && compinit
autoload -Uz vcs_info

# Add hooks
autoload -U add-zsh-hook
add-zsh-hook chpwd chpwd_update_prompt
add-zsh-hook precmd precmd_update_prompt
add-zsh-hook preexec preexec_update_prompt

function chpwd_update_prompt () {
	vcs_info
	ps1_update
}

function precmd_update_prompt () {
	vcs_info
	ps1_update
}

function preexec_update_prompt () {
	vcs_info
	ps1_update
}

setopt prompt_subst

# Make the prompt modular

function ps1_update () {
	# User information: user@machine
	szp_user="%F{yellow}%n%f@%F{yellow)}%m%f "

	# SSH connection?
	szp_ssh="%F{cyan}$([[ ! -z $SSH_CONNECTION ]] && echo "(SSH)")%f "

	# Current working directory, with ~ swapped in for $HOME if applicable
	szp_dir="%F{blue}%~%f "

	# RVM information
	if [[ ! -z ${rvm_path} ]] ; then
		if [[ -f "${rvm_path}/bin/rvm-prompt" ]] ; then
			szp_rvm="%F{red}$(${rvm_path}/bin/rvm-prompt)%f "
		fi
	fi

	# For obvious reasons, the sigil goes LAST
	szp_sigil="
%F{%(!.red.yellow)}%(!.Ω.λ)%f "

export PROMPT="$szp_user$szp_ssh$szp_dir$szp_rvm$szp_sigil"
}

RPROMPT="%F{%(?.green.red)}%?%f"
