# !/bin/bash 
PROJECT_ID=$1
REPO_NAME=$2
BRANCH_NAME=$3
TAG_NAME=$4
SHORT_SHA=$5
CLOUDSDK_COMPUTE_ZONE=$6
CLOUDSDK_CONTAINER_CLUSTER=$7

if [ $BRANCH_NAME != "master" ]
then
    echo "We are not in the master branch! Skipping deployment!"
    exit 0
fi

if [ -z $TAG_NAME ]
then
    echo "No tag was provided! Skipping building deployment!"
    exit 0
fi

echo "Building image $REPO_NAME:$TAG_NAME for $REPO_NAME!"

echo "Building Docker image .."
docker build -t gcr.io/$PROJECT_ID/$REPO_NAME:$TAG_NAME .
echo "Building Docker image finished!"

echo "Pushing Docker image into Google Container Registry .."
docker push -t $TAG_NAME -t $SHORT_SHA
echo "Pushing Docker image into Google Container Registry .. finished!"

echo "Deploying into Kubernetes cluster ($CLOUDSDK_CONTAINER_CLUSTER) .."

echo "Gathering Kubernetes Cluster Credentials .."
gcloud container clusters get-credentials --zone "$CLOUDSDK_COMPUTE_ZONE" "$CLOUDSDK_CONTAINER_CLUSTER"`
echo "Gathering Kubernetes Cluster Credentials .. finished!"

echo "Installing HELM .."
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
echo "Installing HELM .. finished!"

echo "Initializing HELM .."
helm init --upgrade
echo "Initializing HELM .. finished!"

echo "Deployment into Kubernetes cluster ($CLOUDSDK_CONTAINER_CLUSTER) .. finished!"