/* Requires the Docker Pipeline plugin */
pipeline {
    agent any
    stages {
        stage('clone from github') {
            steps {
                /* clone and go into project application */
                bat 'git clone https://github.com/mcmillenchrisj/apcv_405_app.git'
                bat 'cd apcv_405_app'
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
        stage('run docker') {
            steps {
                /* run application */
                bat 'docker run -d mcmillenchrisj/apcv_405_app:latest -p 9090:8080'
            }
        }
        stage('test health endpoint') {
            steps {
                /* test health endpoint on localhost:9090 */
                bat 'curl -i http://localhost:9090/health'
            }
        }
    }
}