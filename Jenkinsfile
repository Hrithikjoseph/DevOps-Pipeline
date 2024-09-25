pipeline {
    agent any // Use any available agent (node)

    stages {
        // Stage 1: Build (Packaging static files)
        stage('Build') {
            steps {
                echo 'Packaging static files...'
                
                // Tool: Zip (for packaging files)
                sh 'zip -r webapp.zip index.html main.css logo.svg'
                
                // Archive the package as a build artifact
                archiveArtifacts artifacts: 'webapp.zip', allowEmptyArchive: false
            }
        }

        // Stage 2: Test
        stage('Test') {
            steps {
                echo 'Running tests...'
                
                // Tool: HTMLHint (for static HTML file linting)
                // Ensure HTMLHint is installed on the Jenkins agent
                sh 'npm install -g htmlhint'
                sh 'htmlhint index.html'
            }
        }

        // Stage 3: Code Quality Analysis
        stage('Code Quality Analysis') {
            steps {
                echo 'Running Code Quality Analysis...'
                
                // Tool: Stylelint (for CSS file linting)
                // Ensure Stylelint is installed on the Jenkins agent
                sh 'npm install -g stylelint'
                sh 'stylelint main.css'
            }
        }

        // Stage 4: Deploy
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                
                // Tool: SCP (for secure file transfer)
                // Ensure you replace the path to your key file
                sh '''
                    scp -i /path/to/your/key.pem webapp.zip ec2-user@3.24.214.141:/var/www/html/
                '''
            }
        }

        // Stage 5: Release
        stage('Release') {
            steps {
                echo 'Releasing the application...'
                
                // Tool: AWS CLI (if using AWS for deployment)
                sh '''
                    aws deploy create-deployment \
                    --application-name MyApp \
                    --deployment-group-name MyDeploymentGroup \
                    --s3-location bucket=mybucket,key=myapp.zip,bundleType=zip
                '''
            }
        }

        // Stage 6: Monitoring and Alerting
        stage('Monitoring and Alerting') {
            steps {
                echo 'Monitoring and Alerting...'
                
                // Tool: Datadog (for monitoring)
                // Example integration with Datadog (ensure Datadog agent is set up)
                sh '''
                    curl -X POST "https://api.datadoghq.com/api/v1/check_run" \
                    -H "Content-Type: application/json" \
                    -H "DD-API-KEY: <your_datadog_api_key>" \
                    -d '{"check": "app.status", "status": 0, "message": "App is running fine"}'
                '''
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
            // Example: Send email notification on failure
            mail to: 'team@example.com',
                subject: "FAILURE: Build ${env.JOB_NAME} ${env.BUILD_NUMBER}",
                body: "The build failed. Please check the Jenkins logs."
        }
    }
}
