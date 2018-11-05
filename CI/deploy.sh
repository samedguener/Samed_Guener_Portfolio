# !/bin/bash 
PROJECT_ID=$1
REPO_NAME=$2
BRANCH_NAME=$3
TAG_NAME=$4
SHORT_SHA=$5

if [ $BRANCH_NAME!="master" ]
then
    echo "We are not in the master branch! Skipping deployment!"
    exit 0
fi

if [ -z $TAG_NAME ]
then
    echo "No tag was provided! Skipping deployment!"
    exit 0
fi

echo "Building image $REPO_NAME:$TAG_NAME for $REPO_NAME!"

echo "Building Docker image .."
docker build -t gcr.io/$PROJECT_ID/$REPO_NAME:$TAG_NAME .
echo "Building Docker image finished!"

echo "Pushing Docker image into Google Container Registry .."
docker push -t $TAG_NAME -t $SHORT_SHA
echo "Pushing Docker image into Google Container Registry finished!"

