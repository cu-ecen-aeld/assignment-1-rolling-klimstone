#!/bin/bash

filesdir="$1"
searchstr="$2"
rc=0
filecount=0
matchinglinecount=0

verifyArguments () {
    if [ -z "$filesdir" ]; then
        echo "argument filesdir not provided"
        rc=1
    elif [ ! -d "$filesdir" ]; then
        echo "$filesdir is not a directory"
        rc=1    
    fi

    if [ -z "$searchstr" ]; then
        echo "argument searchstr not provided"
        rc=1
    fi
}

countFiles () {
    filecount=$(find "$filesdir" -type f | wc -l)
}

countMatchingLines () {
    matchinglinecount=$(grep --recursive "$searchstr" "$filesdir" | wc -l)  
}

main () {
    verifyArguments
    if [ "$rc" != 0 ]; then
        exit "$rc"
    fi

    countFiles
    countMatchingLines
    echo "The number of files are $filecount and the number of matching lines are $matchinglinecount"
    exit "$rc"
}

main
