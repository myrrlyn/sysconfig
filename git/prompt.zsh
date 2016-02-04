function setup_vcs_git () {
	# Configure vcs_info behavior
	#zstyle ':vcs_info:git*' debug true
	# Turn on support for git
	zstyle ':vcs_info:*' enable git
	# Actually use some of the variables
	zstyle ':vcs_info:git*' get-revision true
	zstyle ':vcs_info:git*' check-for-changes true
	# Add hooks
	#zstyle ':vcs_info:git*+set-message:*' hooks git-build-directory-string
	#zstyle ':vcs_info:git*+set-message:*' hooks git-find-untracked

	# Configure vcs_info return strings
	zstyle ':vcs_info:git*' actionformats \
	""
	zstyle ':vcs_info:git*' formats \
	"%B%F{cyan}%b%f%%b [%F{cyan}%0.8i%f] %c%u "
	zstyle ':vcs_info:git*' stagedstr \
	"%F{magenta}+%f"
	zstyle ':vcs_info:git*' unstagedstr \
	"%F{magenta}*%f"

	vcs_info
}

function +vi-git-build-directory-string () {

}

function +vi-git-find-untracked () {
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == "true" ]]; then
		if [[ $(git status --porcelain | grep '??') ]] ; then
			hook_com[staged]="%"
		fi
	fi
}

#function build_prompt_git () {
#	# Untracked files?
#	zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#	function +vi-git-untracked () {
#		if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#			git status --porcelain | grep '??' &> /dev/null ; then
#			# This will show the marker if there are any untracked files in repo.
#			# If instead you want to show the marker only if there are untracked
#			# files in $PWD, use:
#			#[[ -n $(git ls-files --others --exclude-standard) ]] ; then
#			hook_com[staged]+='T'
#		fi
#	}
#	zstyle ':vcs_info:git*+set-message:*' hooks git-st
#	function +vi-git-st () {
#		local ahead behind
#		local -a gitstatus
#
#		ahead="$(git rev-list ${hook_com[branch]}@${upstream}..HEAD 2>/dev/null | wc -l)"
#		(( $ahead )) && gitstatus+=( "+${ahead}" )
#
#		behind="$(git rev-list HEAD..${hook_com[branch]}@${upstream} 2>/dev/null | wc -l)"
#		(( $behind )) && gitstatus+=( "-${behind}" )
#
#		hook_com[misc]+=${(j:/:)gitstatus}
#	}
#	zstyle ':vcs_info:git*+set-message:*' hooks git-remotebranch
#
#	function +vi-git-remotebranch () {
#	    local remote
#
#	    # Are we on a remote-tracking branch?
#	    remote=${$(git rev-parse --verify ${hook_com[branch]}@${upstream} \
#	        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
#
#	    # The first test will show a tracking branch whenever there is one. The
#	    # second test, however, will only show the remote branch's name if it
#	    # differs from the local one.
#	    if [[ -n ${remote} ]] ; then
#	    #if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
#	        hook_com[branch]="${hook_com[branch]} [${remote}]"
#	    fi
#	}
#	echo "${vcs_info_msg_0_} "
#}
