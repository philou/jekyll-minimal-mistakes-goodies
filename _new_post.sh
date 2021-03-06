#!/bin/sh

export POST_NAME=$1
export PUBLISH_DATE=$2

# Display usage if not called correctly
if [[ $# -ne 2 ]] ; then
    echo 'Creates a new post using the Jekyll compose template defined in _config.yml'
    echo 'Usage ./_new_post.sh "POST NAME" PUBLISH_DATE_YYYY-MM-DD'
    exit 1
fi

# start by creating a new post file using jekyll-compose
export POST_FILE_PATH=`bundle exec jekyll post $POST_NAME --extension "markdown" | grep "New post created" | grep --only-matching -e "_posts/.*\.markdown"`
echo "New post created" $POST_FILE_PATH

# extract the post file name from the created file path
export POST_FILE_NAME=`echo $POST_FILE_PATH | sed 's:^.*_posts/\(.*\)\.markdown.*$:\1:'`

# prepare an empty image directory
export IMAGE_DIR_PATH=imgs/$POST_FILE_NAME
mkdir $IMAGE_DIR_PATH
echo "Image dir created" $IMAGE_DIR_PATH

# Update date and image dir in the post file because jekyll-compose does not handle them
less $POST_FILE_PATH | sed 's/<POST_FILE_NAME>/'$POST_FILE_NAME'/' | sed 's/date:.*/date: "'$PUBLISH_DATE'"/' > $POST_FILE_PATH.tmp
mv -f $POST_FILE_PATH.tmp $POST_FILE_PATH

echo "Updated post front matter:"
cat $POST_FILE_PATH
