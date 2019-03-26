pipeline {

    environment {
        registry = "registry.buzzle.io"
        image = "samed_guener_portfolio"
        registryCredential = 'buzzle_docker_registry'
    }

    agent any

    stages {
        stage('Building Docker Image') {
            steps {
                script {
                    echo "--- Building Docker Image ---"
                    docker.build registry + image + ":$BUILD_NUMBER"
                }
            }
        }
    }
}