pipeline {
    agent any
    stages {
        /*stage('Checkout') {
            steps {
                // Clone the repository
                git url: 'https://github.com/Hrithikjoseph/DevOps-Pipeline', credentialsId: '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'
            }
        }*/

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

        // Stage 2: Code Quality Analysis (HTML/CSS linting)
        stage('Code Quality Analysis') {
            steps {
                echo 'Running code quality checks...'

                // Check for HTML/CSS issues using linters
                // Assuming `htmlhint` and `csslint` are available in the environment
                sh 'htmlhint index.html'
                sh 'csslint main.css'
            }
        }

        // Stage 3: Deploy (Deploy static files)
        stage('Deploy') {
            steps {
                echo 'Deploying static files...'

                // Example: Deploy to an Apache/Nginx web server or AWS S3 bucket
                // Adjust the deployment script based on your environment
                sh '''
                   scp -i "/c/Users/hrith/Downloads/mykey.pem" webapp.zip ec2-user@3.24.214.141:/var/www/html/
                   ssh -i "/c/Users/hrith/Downloads/mykey.pem" ec2-user@3.24.214.141 "cd /var/www/html && unzip -o webapp.zip"
                '''

                // OR Deploy to AWS S3 if applicable
                // sh 'aws s3 cp webapp.zip s3://your-s3-bucket-name/webapp.zip'
            }
        }

        // Optional: Monitoring and alerting stage (Uptime monitoring)
        stage('Monitoring and Alerting') {
            steps {
                echo 'Setting up basic monitoring...'

                // Example: Use cURL to check if the website is up
                sh 'curl -Is http://yourwebsite.com | head -n 1'

                // OR Integrate with external monitoring services like UptimeRobot or Datadog
                // sh 'curl -X POST "https://api.datadoghq.com/api/v1/check_run" -H "DD-API-KEY: <your_api_key>" -d \'{"check": "webapp.status", "status": 0, "message": "Website is up"}\''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
            // Send email notification 
            mail to: 'hrithikjsoeph72@gmail.com',
                 subject: "Build ${env.JOB_NAME} success",
                 body: "The build successful."
        }

        failure {
            echo 'Pipeline failed. Check the logs for details.'
            // Send email notification in case of failure
            /*mail to: 'hrithikjsoeph72@gmail.com',
                 subject: "Build ${env.JOB_NAME} failed at stage ${env.STAGE_NAME}",
                 body: "The build failed. Please review the Jenkins logs."*/
        }
    }
}
