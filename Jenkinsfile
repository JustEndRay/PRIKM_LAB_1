pipeline {
    agent any

    stages {
        stage('Start') {
            steps {
                echo 'Lab_2: started by GitHub'
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

        stage('Push to registry') {
            steps {
                withDockerRegistry([ credentialsId: "justendray", url: "" ]) {
                    sh "docker push justendray/prikm:latest"
                    sh "docker push justendray/prikm:$BUILD_NUMBER"
                }
            }
        }
    
        stage('Deploy image') {
            steps {
                sh "docker run -d -p 80:80 justendray/prikm"
            }
        }
    }
}




