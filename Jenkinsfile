/* Requires the Docker Pipeline plugin */
pipeline {
    agent any
    stages {
        stage('clone from github') {
            steps {
                /* clone and go into project application */
                sh 'git clone https://github.com/mcmillenchrisj/apcv_405_app.git'
                sh 'cd apcv_405_app'
            }
        stage('run tests') {
                /* run tests */
                sh 'dotnet test apcv_405_app.sln'
            }
        stage('docker build and name image') {
                /* build docker container */
                sh 'docker build -t mcmillenchrisj/apcv_405_app:latest .'
            }
        stage('push to dockerhub') {
                /* push to dockerhub */
                sh 'docker push mcmillenchrisj/apcv_405_app:latest'
            }
        stage('run docker') {
                /* run application */
                sh 'docker run -p 9090:8080 mcmillenchrisj/apcv_405_app:latest'
            }
        stage('test health endpoint') {
                /* test health endpoint on localhost:9090 */
                sh 'curl -i http://localhost:9090/health'
            }
        }
    }
}