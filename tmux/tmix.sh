alias tmux="tmux -2u"

# In case aliases don't work for some reason, stick the -2u flag in front of
# whatever options were given.
function tmux () {
	tmux -2u "$@"
}

function tmix () {
	trim () { echo $1; }

# Permit running tmix, no arguments, as a shorthand for attaching to the user
# session.
	if [[ -z "$1" ]] ; then
		tmux_base="$(whoami)"
# Also permit using tmix for tmux ls. I and U are right next to each other after
# all.
	elif [[ "$1" == "ls" ]] ; then
		pgrep tmux > /dev/null && tmux ls || echo "No tmux server running!"
	else
		tmux_base="$1"
	fi

# Check if the specified base session is running, and if not, make it so.
	tmux_nb=$(trim `tmux ls | grep "^${tmux_base}" | wc -1`)
	if [[ "${tmux_nb}" == "0" ]] ; then
		echo "Launching tmux base session ${tmux_base} ..."
		tmux new-session -s "${tmux_base}"
# Don't attach to a tmux session from inside a tmux session. That's a recipe for
# disaster.
	elif [[ -z "${TMUX}" ]] ; then
		echo "Launching copy of base session ${tmux_base} ..."
		[[ ! -z "$2" ]] && tmux_sesh="$2" || tmux_sesh="$(date +%Y%m%d%H%M%S)"
		tmux new-session -d -t "${tmux_base}" -s "${tmux_sesh}"
# Spawn a new window, if the user asked for one.
		if [[ "$3" == "1" ]] ; then
			tmux new-window
		fi
		tmux attach-session -t "${tmux_sesh}" \; set-option destroy-unattached
	fi
}
