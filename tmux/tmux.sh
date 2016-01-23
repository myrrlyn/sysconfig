alias tmux="tmux -2u"

function tmix () {
	trim () { echo $1; }

	if [[ -z "$1" ]] ; then
		echo "Specify session name as first argument"
	# tmix, tmux, potayto, potahto
	elif [[ "$1" == "ls" ]] ; then
		pgrep tmux > /dev/null && tmux ls || echo "No tmux servers present"
	else
		base_session="$1"
		# This apparently works without trim() everywhere but OSX
		tmux_nb=$(trim `tmux ls | grep "^$base_session" | wc -l`)
		if [[ "$tmux_nb" == "0" ]] ; then
			echo "Launching tmux base session $base_session ..."
			tmux -2u new-session -s "$base_session"
		# Ensure we're not already IN a tmux before attaching/copying
		elif [[ -z "$TMUX" ]] ; then
			echo "Launching copy of base session $base_session ..."
			# Use a provided string or the timestamp as new session id
			[[ ! -z "$2" ]] && session_id="$2" || session_id=`date +%Y%m%d%H%M%S`
			# Create new session w/o attaching and link it to base session, so
			# windows are shared
			tmux -2u new-session -d -t "$base_session" -s "$session_id"
			if [[ "$3" == "1" ]] ; then
				tmux -2u new-window
			fi
			# Finally, attach to the new session and set it to die on abandon
			tmux -2u attach-session -t $session_id \; set-option destroy-unattached
		fi
	fi
}
