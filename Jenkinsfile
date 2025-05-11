pipeline {   
    agent any
    
    stages {
        stage('Start') {
            steps {
                echo 'Lab2: nginx/custom'
            }
        }
        
        
        stage('Build nginx/custom') {
            steps {
                sh 'docker build -t nginx/custom:latest .'
            }
        }
        
        stage('Test nginx/custom') {
            steps {
                echo 'Pass'
            }
        }
        
        stage('Deploy nginx/custom'){
            steps{
                sh "docker run -d -p 80:80 nginx/custom:latest"
            }
        }
        
        stage('Cleanup') {
            steps {
                echo 'Cleaning up unused Docker resources...'
                sh 'docker system prune -f'
            }
        }
    }
}


