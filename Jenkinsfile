
pipeline {

    environment {
        image = "registry.buzzle.io/samed_guener_portfolio"
        registryCredential = 'buzzle_docker_registry'
    }

    agent any

    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    echo "--- Building Docker Image ---"
                    def dockerImage = docker.build image + ":$BUILD_NUMBER"

                    echo "--- Pushing Docker Image ---"
                    docker.withRegistry( 'https://registry.buzzle.io', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}