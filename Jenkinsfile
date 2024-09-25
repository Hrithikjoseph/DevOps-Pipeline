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

                // Install Stylelint and related packages
                sh 'npm install stylelint stylelint-config-standard --save-dev'
            }
        }

        // Stage 2: Test
        stage('Test') {
            steps {
                echo 'Running tests...'
                
                // Tool: JUnit (for testing)
                // This assumes you have a JUnit test suite ready in your project
                sh 'mvn test' // Replace with the command to run your JUnit tests
            }
        }

       //stage('Code Quality Analysis') {
    //steps {
        //echo 'Running Code Quality Analysis...'
        
        // Run Stylelint and auto-fix errors
       // sh 'npx stylelint "**/*.css" --fix'
        
        // Run CodeClimate analysis
      /*  sh '''
            curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > ./cc-test-reporter
            chmod +x ./cc-test-reporter
            ./cc-test-reporter before-build
            ./cc-test-reporter after-build --exit-code $? --debug --insecure --batch-size 1000
        '''
    }
} */
        
        stage('Deploy to Test') {
            steps {
                echo 'Deploying to test environment...'
                
                // Example using Docker
                sh '''
                    docker build -t myapp-test .
                    docker stop myapp-test || true
                    docker rm myapp-test || true
                    docker run -d --name myapp-test -p 8080:80 myapp-test
                '''
            }
        }
        
        stage('Release to Production') {
            steps {
                echo 'Releasing to production environment...'
                
                // Example using AWS CodeDeploy
                sh '''
                    aws deploy create-deployment \
                        --application-name MyApp \
                        --deployment-group-name MyProductionGroup \
                        --s3-location bucket=my-artifacts-bucket,key=webapp.zip,bundleType=zip
                '''
            }
        }
        
        stage('Monitoring and Alerting') {
            steps {
                echo 'Setting up monitoring and alerting...'
                
                // Example using Datadog
                sh '''
                    curl -X POST "https://api.datadoghq.com/api/v1/series" \
                    -H "Content-Type: application/json" \
                    -H "DD-API-KEY: ${DATADOG_API_KEY}" \
                    -d @- << EOF
                    {
                        "series": [
                            {
                                "metric": "myapp.deployment",
                                "points": [[$(date +%s), 1]],
                                "type": "gauge",
                                "tags": ["environment:production"]
                            }
                        ]
                    }
                    EOF
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
