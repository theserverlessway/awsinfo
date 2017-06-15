
if [[ $# -gt 0 ]]
then
    if [[ -d "$DIR/commands/$1" ]]
    then
        echosuccess Available Commands:
        find $DIR/commands/$1 -name "*.bash" | sed s/index//g | sed s/.bash//g | awk '{n=split($0,array,"/"); print "  " array[n-1] " " array[n]}' | sort
    else
        echo Service "$1" is not supported
    fi
else
    echosuccess Supported Services:
    ls $DIR/commands | sort | sed 's/^/  /'
fi

