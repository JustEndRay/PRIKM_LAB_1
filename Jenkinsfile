pipeline {
    agent any

    options {
        office365ConnectorWebhooks([
            webhooks: [
                [
                    url: 'https://lpnu.webhook.office.com/webhookb2/...', 
                    status: 'STARTED', 
                    startNotification: true
                ]
            ]
        ])
    }

    stages {
        stage('Start') {
            steps {
                echo 'Lab_3: started by GitHub'
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
        stage('Deploy image') {
            steps {
                sh "docker stop nginx_container || true"
                sh "docker rm nginx_container || true"
                sh "docker run -d -p 80:80 --name nginx_container justendray/prikm"
            }
        }
    }

    post {
        success {
            emailext(
                subject: "Build Success",
                body: "Build ${currentBuild.fullDisplayName} was successful.",
                to: 'andrii.pastushuk.mitpa.2024@lpnu.ua'
            )
            office365ConnectorWebhooks([
                webhooks: [
                    [
                        url: 'https://lpnu.webhook.office.com/webhookb2/...',
                        status: 'SUCCESS'
                    ]
                ]
            ])
        }
        failure {
            office365ConnectorWebhooks([
                webhooks: [
                    [
                        url: 'https://lpnu.webhook.office.com/webhookb2/...',
                        status: 'FAILURE'
                    ]
                ]
            ])
        }
    }
}
