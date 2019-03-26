pipeline {

    environment {
        registry = "registry.buzzle.io"
        registryCredential = 'buzzle_docker_registry'
    }

    agent any

    stages {
        stage('Building Docker Image') {
            steps {
                echo "--- Building Docker Image ---"
                docker.build registry + ":$BUILD_NUMBER"
            }
        }
    }
}