AWS_OPTIONS=""
HELP=""
SOURCE=""

if [[ "$#" -gt 0 ]]
then
	# Parse common AWSCLI arguments so subcommands don't have to deal with them
	args=("$@")
	i="0"

	while [[ $i -lt $# ]]
	do
		current=${args[$i]}
		case "$current" in
			--profile)
				if [[ $(($i+1)) -eq $(($#)) ]]
				then
					echo Please provide a profile with the --profile option
					exit 1
				else
					AWS_OPTIONS+=" --profile ${args[$i+1]} "
					unset args[$i]
					unset args[$(($i+1))]
					i=$(($i+1))
				fi
			;;
			--region)
				if [[ $(($i+1)) -eq $(($#)) ]]
				then
					echo Please provide a region with the --region option
					exit 1
				else
					AWS_OPTIONS+=" --region ${args[$i+1]} "
					unset args[$i]
					unset args[$(($i+1))]
					i=$(($i+1))
				fi
			;;
      --help)
          HELP="TRUE"
      ;;
      --source)
          SOURCE="TRUE"
      ;;
			*)
			;;
		esac
		i=$(($i+1))
	done

	set -- ${args[@]+"${args[@]}"}
fi
