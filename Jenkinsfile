pipeline {
    agent any

    stages {
        // Stage 1: Build
        stage('Build') {
            steps {
                echo 'Building...'
                // Build commands, e.g., Docker build or npm install, depending on your project
                sh 'npm install'  // For web apps
            }
        }

        // Stage 2: Test
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Running unit tests, use your preferred test framework like JUnit
                sh 'npm test'  // Example using Jest or Mocha for JavaScript projects
            }
        }

        // Stage 3: Code Quality
        stage('Code Quality') {
            steps {
                echo 'Running code quality analysis...'
                // SonarQube analysis or CodeClimate
                sh 'sonar-scanner'  // Requires SonarQube plugin configured
            }
        }

        // Stage 4: Deploy to Test Environment
        stage('Deploy to Test') {
            steps {
                echo 'Deploying to test environment...'
                // Deploy to a staging server, Docker container, etc.
                sh 'docker-compose up -d'  // Docker example
            }
        }

        // Stage 5: Release to Production
        stage('Release to Production') {
            steps {
                input 'Ready to deploy to production?'  // Manual approval step
                echo 'Deploying to production...'
                sh 'aws deploy'  // Example AWS deployment command
            }
        }

        // Stage 6: Monitoring & Alerting
        stage('Monitoring') {
            steps {
                echo 'Setting up monitoring...'
                // Use Datadog, New Relic, etc.
                sh 'datadog-agent start'  // Example for Datadog
            }
        }
    }

    post {
        // Notifications
        success {
            echo 'Pipeline completed successfully.'
            mail to: 'team@example.com',
                subject: "SUCCESS: Pipeline",
                body: "The Jenkins pipeline completed successfully."
        }
        failure {
            echo 'Pipeline failed!'
            mail to: 'team@example.com',
                subject: "FAILURE: Pipeline",
                body: "The Jenkins pipeline failed. Please check the logs."
        }
    }
}
