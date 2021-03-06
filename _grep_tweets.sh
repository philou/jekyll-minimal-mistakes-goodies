#!/bin/sh

export ME=`basename "$0"`
export POST_FILE_PATH=$1

# Display usage if not called correctly
if [[ $# -ne 1 ]] ; then
    echo "Greps a post for bold sections and outputs them as a '-' prepended list of 'tweetable' sentences."
    echo "Usage ./$ME POST_FILE_PATH"
    exit 1
fi


# I use awk because `sed 's/^/- /g'` was crashing on emojis...
egrep --only-matching "(^\s*(\*|[1-9]\.)\s*)?\*\*([^\*]|\*[^\*])*\*\*" $POST_FILE_PATH | sed 's/\*\*//g' | awk '{print "- " $0}'
