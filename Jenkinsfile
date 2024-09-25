pipeline {
    agent any

    tools {
        // Adjust these names to match your Jenkins tool configurations
        maven 'Maven'  // Use the name configured in Jenkins for Maven
        jdk 'JDK'      // Use the name configured in Jenkins for JDK
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'mvn clean package'
                archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
                junit '**/target/surefire-reports/*.xml'
            }
        }

        stage('Code Quality Analysis') {
            steps {
                echo 'Running Code Quality Analysis...'
                sh 'mvn jacoco:report'
                // Assuming CodeClimate CLI is installed on the Jenkins agent
                sh '''
                    export CC_TEST_REPORTER_ID=your_codeclimate_reporter_id
                    cc-test-reporter before-build
                    cc-test-reporter format-coverage --input-type jacoco target/site/jacoco/jacoco.xml
                    cc-test-reporter upload-coverage
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Example: Deploy using a script or a Jenkins plugin
                sh './deploy.sh' // A custom deploy script
            }
        }

        stage('Release') {
            steps {
                echo 'Releasing the application...'
                // Assuming AWS CLI is installed on the Jenkins agent
                sh '''
                    aws deploy create-deployment \
                    --application-name MyApp \
                    --deployment-group-name MyDeploymentGroup \
                    --s3-location bucket=mybucket,key=myapp.zip,bundleType=zip
                '''
            }
        }

        stage('Monitoring and Alerting') {
            steps {
                echo 'Monitoring and Alerting...'
                // Using a Jenkins plugin for Datadog integration
                datadog(tags: ['env:production', 'app:MyApp'])
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
            mail to: 'team@example.com',
                 subject: "FAILURE: Build ${env.JOB_NAME} ${env.BUILD_NUMBER}",
                 body: "The build failed. Please check the Jenkins logs."
        }
    }
}
