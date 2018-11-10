# !/bin/bash 
PROJECT_ID=$1
REPO_NAME=$2
BRANCH_NAME=$3
# using SHORT_SHA as tag, since tags are currently not supported by Github GCB integration
TAG_NAME=$4
CLOUDSDK_COMPUTE_ZONE=$5
CLOUDSDK_CONTAINER_CLUSTER=$6

if [ $BRANCH_NAME != "master" ]
then
    echo "We are not in the master branch! Skipping deployment!"
    exit 0
fi

echo "Updating repositories .."
apt-get update -y
echo "Updating repositories .. finished!"

echo "Installing Docker requirements .."
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
echo "Installing Docker requirements .. finished!"

echo "Installing Docker .."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -y
apt-get install -y docker-ce

while (! docker stats --no-stream ); do
  # Docker takes a few seconds to initialize
  echo "Waiting for Docker to launch..."
  sleep 1
done

echo "Installing Docker .. finished!"

echo "Building image ${REPO_NAME,,}:$TAG_NAME for $REPO_NAME!"

echo "Building Docker image .."
docker build -t gcr.io/$PROJECT_ID/${REPO_NAME,,}:$TAG_NAME .
echo "Building Docker image finished!"

echo "Pushing Docker image into Google Container Registry .."
docker push -t $TAG_NAME
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