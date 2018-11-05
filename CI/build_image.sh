# !/bin/bash 
PROJECT_ID=$1
REPO_NAME=$2
BRANCH_NAME=$3
TAG_NAME=$4

if [ $BRANCH_NAME!="master" ]
then
    echo "We are not in the master branch! Skipping building of Docker image!"
    exit 0
fi

if [ -z $TAG_NAME ]
then
    echo "No tag was provided! Skipping building of Docker image!"
    exit 0
fi

echo "Building image $REPO_NAME:$TAG_NAME for $REPO_NAME!"