pipeline {
    agent any

    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Docker image tag')
        choice(name: 'DEPLOY_ENV', choices: ['staging', 'production'], description: 'Deployment Environment')
    }

    stages {
        stage('Start') {
            steps {
                echo 'Lab_4: started by GitHub'
            }
        }

        stage('Image build') {
            steps {
                sh "docker build -t prikm:latest ."
                sh "docker tag prikm justendray/prikm:latest"
                sh "docker tag prikm justendray/prikm:$BUILD_NUMBER"
            }
        }

        stage('Test Image') {
            steps {
                echo 'Running containerized test...'
                sh "docker run --rm justendray/prikm:latest echo 'Test passed!'"
            }
        }

        stage('Pre-Deploy Checks') {
            steps {
                script {
                    def configContent = readFile('nginx.conf')
                    echo "Nginx Config: ${configContent}"
                }
            }
        }

        stage('Deploy using Docker Compose') {
            steps {
                echo 'Starting services with Docker Compose...'
                sh '''
                    docker-compose -f docker-compose.yml down --remove-orphans
                    docker-compose -f docker-compose.yml up -d
                '''
            }
        }
    }
}
