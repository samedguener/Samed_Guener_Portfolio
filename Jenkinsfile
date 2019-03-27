
def dockerImage

pipeline {

    environment {
        image = "registry.buzzle.io/samed_guener_portfolio"
        registryCredential = 'buzzle_docker_registry'
    }

    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "--- Building Docker Image ---"
                    dockerImage = docker.build image + ":$BUILD_NUMBER"
                }
            }
        } 
        
        stage('Push Docker Image') {
            steps {
                script {
                    echo "--- Pushing Docker Image ---"
                    docker.withRegistry( 'https://registry.buzzle.io', registryCredential ) {
                        dockerImage.push()
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
}