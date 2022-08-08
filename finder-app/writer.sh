#!/bin/bash

writefile="$1"
writestr="$2"
rc=0

verifyArguments () {
    if [ -z "$writefile" ]; then
        echo "argument writefile not provided"
        rc=1
    fi

    if [ -z "$writestr" ]; then
        echo "argument writestr not provided"
        rc=1
    fi
}

createWriteFile () {
    if [ ! -f "$writefile" ]; then
        local lparentdir=$(dirname "$writefile")
        if [ ! -d "$lparentdir" ]; then
            mkdir -p "$lparentdir"
        fi

        touch "$writefile"

        if [ "$?" != 0 ]; then
            rc=1
            echo "file $writefile could not be created"
            exit "$rc"
        fi
    fi
}

insertWriteStr () {
    echo "$writestr" > "$writefile"
}

main () {
    verifyArguments
    if [ "$rc" != 0 ]; then
        exit "$rc"
    fi

    createWriteFile
    
    insertWriteStr
}

main
