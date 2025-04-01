pipeline {
    agent any

options {
        office365ConnectorWebhooks {
            webhooks {
                webhook {
                name('Teams-O365')
                url('https://lpnu.webhook.office.com/webhookb2/8418f46b-fca7-4175-a63d-71875f1d0283@7631cd62-5187-4e15-8b8e-ef653e366e7a/IncomingWebhook/03c938889f9b41939ac73005b6124db3/5b605148-d3bc-4f02-a915-417fbd0843c8/V28y97CRZg9sKmItuqS167Y7C7h3yP90PhPLVWywuNsSs1')
                startNotification(false)
                notifySuccess(true)
                notifyAborted(false)
                notifyNotBuilt(false)
                notifyUnstable(true)
                notifyFailure(true)
                notifyBackToNormal(true)
                notifyRepeatedFailure(false)
                timeout(30000)
            }
        }
    }
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

        // stage('Push to registry') {
        //     steps {
        //         withDockerRegistry([ credentialsId: "justendray", url: "" ]) {
        //             sh "docker push justendray/prikm:latest"
        //             sh "docker push justendray/prikm:$BUILD_NUMBER"
        //         }
        //     }
        // }
    
        stage('Deploy image') {
            steps {
                sh "docker run -d -p 80:80 justendray/prikm"
            }
        }
    }
}





