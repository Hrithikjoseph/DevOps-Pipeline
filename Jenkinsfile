pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'docker build -t my-web-app .'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh './gradlew test'
            }
            post {
                always {
                    junit '**/build/test-results/test/*.xml'  // Collect JUnit test results
                }
            }
        }

        stage('Code Quality Analysis') {
            steps {
                echo 'Running CodeClimate analysis...'
                sh '''
                cc-test-reporter before-build
                ./gradlew test
                cc-test-reporter after-build --exit-code $?
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                sh 'docker-compose up -d'
            }
        }

        stage('Release') {
            steps {
                echo 'Promoting to production environment...'
                sh '''
                aws deploy create-deployment \
                    --application-name MyWebApp \
                    --deployment-group-name MyDeploymentGroup \
                    --github-location repository=MyGitHubRepo,commitId=HEAD
                '''
            }
        }

        stage('Monitoring and Alerting') {
            steps {
                echo 'Setting up monitoring and alerting...'
                // Use Datadog for monitoring the application
                sh 'datadog-agent status'  // Assuming Datadog agent is installed and configured
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed, sending alerts...'
        }
    }
}
