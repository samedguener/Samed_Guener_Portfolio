# !/bin/bash 
PROJECT_ID=$1
REPO_NAME=$2
BRANCH_NAME=$3
# using SHORT_SHA as tag, since tags are currently not supported by Github GCB integration
TAG_NAME=$4
CLOUDSDK_COMPUTE_ZONE=$5
CLOUDSDK_CONTAINER_CLUSTER=$6

function install_docker () {
    echo "Installing Docker requirements .."
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    if [ $? -eq 0 ]; then
        echo "Installing Docker requirements .. finished!"
    else
        echo "Installing Docker .. failed!"
        exit 1
    fi

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

    if [ $? -eq 0 ]; then
        echo "Installing Docker .. finished!"
    else
        echo "Installing Docker .. failed!"
        exit 1
    fi
}

function build_push_docker_image () {
    echo "Building image ${REPO_NAME,,}:$TAG_NAME for $REPO_NAME!"

    echo "Building Docker image .."
    docker build -t gcr.io/$PROJECT_ID/${REPO_NAME,,}:$TAG_NAME .
    echo "Building Docker image finished!"

    echo "Pushing Docker image into Google Container Registry .."
    docker push gcr.io/$PROJECT_ID/${REPO_NAME,,}:$TAG_NAME
    echo "Pushing Docker image into Google Container Registry .. finished!"

    if [ $? -eq 0 ]; then
        echo "Building image ${REPO_NAME,,}:$TAG_NAME for $REPO_NAME .. finished!"
    else
        echo "Building image ${REPO_NAME,,}:$TAG_NAME for $REPO_NAME .. failed!"
        exit 1
    fi
}

function get_k8s_credentials () {
    echo "Gathering Kubernetes Cluster Credentials .."
    gcloud container clusters get-credentials --zone "$CLOUDSDK_COMPUTE_ZONE" "$CLOUDSDK_CONTAINER_CLUSTER"

    if [ $? -eq 0 ]; then
        echo "Gathering Kubernetes Cluster Credentials .. finished!"
    else
        echo "Gathering Kubernetes Cluster Credentials .. failed!"
        exit 1
    fi   
}

function install_helm () {
    echo "Installing and initializing HELM .."
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
    chmod 700 get_helm.sh
    ./get_helm.sh
    helm init --upgrade

    if [ $? -eq 0 ]; then
        echo "Initializing and initializing HELM .. finished!"
    else
        echo "Initializing and initializing HELM .. failed!"
        exit 1
    fi
}

function deploy_image () {
    get_k8s_credentials
    install_helm

    echo "Deploying into Kubernetes cluster ($CLOUDSDK_CONTAINER_CLUSTER) .."

    if [ $? -eq 0 ]; then
        echo "Deployment into Kubernetes cluster ($CLOUDSDK_CONTAINER_CLUSTER) .. finished!"
    else
        echo "Deployment into Kubernetes cluster ($CLOUDSDK_CONTAINER_CLUSTER) .. failed!"
        exit 1
    fi
}

if [ $BRANCH_NAME != "master" ]
then
    echo "We are not in the master branch! Skipping deployment!"
    exit 0
fi

echo "Updating repositories .."
apt-get update -y
echo "Updating repositories .. finished!"

install_docker
build_push_docker_image
get_k8s_credentials
install_helm
deploy_image