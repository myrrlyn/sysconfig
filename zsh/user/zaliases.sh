# Add some flair to ls
case $(uname -s) in
	Darwin)
		alias ls='ls -FGh'
		;;
	Linux)
		alias ls='ls --color=auto -Fh'
		;;
esac
