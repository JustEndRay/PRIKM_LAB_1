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



