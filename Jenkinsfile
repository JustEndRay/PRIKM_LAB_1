pipeline {
    agent any

    // Use the 'options' block instead of 'properties' for defining webhook configurations
    options {
        office365ConnectorWebhooks([
            webhooks([
                webhook([
                    name: 'Teams-O365',
                    url: 'https://lpnu.webhook.office.com/webhookb2/8418f46b-fca7-4175-a63d-71875f1d0283@7631cd62-5187-4e15-8b8e-ef653e366e7a/IncomingWebhook/0e7f85b5c10c442a99ae533db00b229f/5b605148-d3bc-4f02-a915-417fbd0843c8/V29Y-V7QzJXfaIIZT1xgYmcjzSJtFPuNFZfEvIzhdWrpo1',
                    startNotification: false,
                    notifySuccess: true,
                    notifyAborted: false,
                    notifyNotBuilt: false,
                    notifyUnstable: true,
                    notifyFailure: true,
                    notifyBackToNormal: true,
                    notifyRepeatedFailure: false,
                    timeout: 30000
                ])
            ])
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
                sh "docker run -d -p 8080:80 --name nginx_container justendray/prikm"
            }
        }
    }
}
