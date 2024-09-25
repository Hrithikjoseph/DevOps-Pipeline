pipeline {
    agent any // Use any available agent (node)

    stages {
        // Stage 1: Build (Packaging static files)
        stage('Build') {
            steps {
                echo 'Packaging static files...'

                // Create a ZIP archive of the web app (HTML, CSS, SVG)
                sh 'zip -r webapp.zip index.html main.css logo.svg'
                
                // Archive the package as a build artifact
                archiveArtifacts artifacts: 'webapp.zip', allowEmptyArchive: false
            }
        }

        // Stage 2: Test
        stage('Test') {
            steps {
                echo 'Running tests...'
                
                // Example: Run unit tests using JUnit
                // Adjust this depending on your testing framework (JUnit, Selenium, etc.)
                sh 'mvn test'
                
                // Publish test results
                junit '*/target/surefire-reports/*.xml'
            }
        }

        // Stage 3: Code Quality Analysis
        stage('Code Quality Analysis') {
            steps {
                echo 'Running Code Quality Analysis...'
                
                // Ensure the test coverage report is generated first (e.g., Jacoco for Java)
                sh 'mvn jacoco:report'
                
                // Upload the coverage to CodeClimate
                sh '''
                    cc-test-reporter before-build
                    cc-test-reporter format-coverage --input-type jacoco target/site/jacoco/jacoco.xml
                    cc-test-reporter upload-coverage
                '''
            }
        }

        // Stage 4: Deploy
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                
                // Example: Deploy to a specific environment, adjust this to your specific deployment method
                sh 'mvn spring-boot:run' // Replace with your actual deployment command
            }
        }

        // Stage 5: Release
        stage('Release') {
            steps {
                echo 'Releasing the application...'
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
                
                // Example: Integrate with Datadog or New Relic
                // Adjust this to your monitoring tool
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
