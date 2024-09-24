pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git branch: 'main', url: 'https://github.com/Hrithikjoseph/DevOps-Pipeline'
            }
        }

        stage('Build') {
            steps {
                // For HTML/CSS projects, no actual "build" is required
                echo 'Building the website (static HTML/CSS)'
            }
        }

        stage('Test') {
            steps {
                // Example step for testing HTML/CSS syntax (optional)
                echo 'Testing website for any HTML/CSS errors'
            }
        }

        stage('Deploy') {
            steps {
                // Deploy to the target server (can be set up via rsync, FTP, etc.)
                echo 'Deploying the website'
            }
        }
    }

   post {
    success {
        mail to: 'team@example.com',
            subject: "SUCCESS: Build ${env.JOB_NAME} ${env.BUILD_NUMBER}",
            body: "The build was successful."
    }
    failure {
        mail to: 'team@example.com',
            subject: "FAILURE: Build ${env.JOB_NAME} ${env.BUILD_NUMBER}",
            body: "The build failed. Please check the Jenkins logs."
    }
}
}

