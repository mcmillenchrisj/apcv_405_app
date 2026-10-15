/* Requires the Docker Pipeline plugin */
pipeline {
    agent any
    stages {
        stage('get files from github') {
            steps {
                /* check if there was a previous build */
                script {
                    if (fileExists('apcv_405_app')) {
                        bat 'git pull origin main'
                    } else {
                        /* clone and go into project application */
                        bat 'git clone https://github.com/mcmillenchrisj/apcv_405_app.git'
                        bat 'cd apcv_405_app'
                    }
                }
            }
        }
        stage('run tests') {
            steps {
                /* run tests */
                bat 'dotnet test apcv_405_app.sln'
            }
        }
        stage('docker build and name image') {
            steps {
                /* build docker container */
                bat 'docker build -t mcmillenchrisj/apcv_405_app:latest .'
            }
        }
        stage('push to dockerhub') {
            steps {
                /* push to dockerhub */
                bat 'docker push mcmillenchrisj/apcv_405_app:latest'
            }
        }
        stage('run docker and name container') {
            steps {
                /* run application */
                bat 'docker run -d --name apcv_405_app -p 9090:8080 mcmillenchrisj/apcv_405_app:latest'
            }
        }
        stage('test health endpoint') {
            steps {
                /* test health endpoint on localhost:9090 */
                bat 'powershell -Command Invoke-WebRequest -Uri "http://localhost:9090/health" -UseBasicParsing'
            }
        }
    }
    post {
        always {
            /* clean up docker images and containers */
            bat 'docker stop apcv_405_app'
            bat 'docker rm apcv_405_app'
            bat 'docker image prune -f'
        }
        success {
            bat repoStatusUpdate(state: 'success', description: 'devops-pipeline-build Successfully Completed!')
        }
        failure {
            bat repoStatusUpdate(state: 'failure', description: 'devops-pipeline-build failed.')
        }
    }
}