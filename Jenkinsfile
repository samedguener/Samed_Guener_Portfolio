pipeline {

    environment {
        image = "registry.buzzle.io/samed_guener_portfolio"
        registryCredential = 'buzzle_docker_registry'
    }

    agent any

    stages {
        stage('Building Docker Image') {
            steps {
                script {
                    def dockerHome = tool 'Docker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                    
                    echo "--- Building Docker Image ---"
                    docker.build image + ":$BUILD_NUMBER"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo "--- Pushing Docker Image ---"
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}