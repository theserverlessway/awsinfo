echo "Available Commands:"

find $DIR/commands -type f | sed s/index//g | sed s/.bash//g | awk '{n=split($0,array,"/"); print "  " array[n-1] " " array[n]}' | sort