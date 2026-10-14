## CI/CD Pipeline

This project includes an automated CI/CD pipeline to deploy the APCV_405_APP using Jenkins that:

1. Pulls code from GitHub
2. Runs automated tests
3. Builds a Docker image
4. Pushes the image to DockerHub
5. Deploys the container locally
6. Performs health check on the /health endpoint

## Required Software
Git: https://git-scm.com/downloads  
Docker Desktop: https://www.docker.com/products/docker-desktop/  
Java SDK v21: https://www.oracle.come/java/technologies/downloads/#jdk21-windows  
.NET8: https://dotnet.microsoft.com/en-us/download/dotnet/8.0  
Jenkins: https://www.jenkins.io/doc/book/installing/  

## Application Viewing
If running the app in the pipeline, you must remove the post section that closes the application from the Jenkinsfile.  
If running locally, the application can be viewed on http://localhost:9090

### Pipeline Status
- Build: [![Build Status](http://localhost:8080/buildStatus/icon?job=devops-pipeline-project)](http://localhost:8080/job/devops-pipeline-project/)

## Manual Deployment

Get code locally:   
git clone mcmillenchrisj/apcv_405_app.git  
cd apcv_405_app  

Run tests locally:  
dotnet test apcv_405_app.sln  

Build and run locally with Docker:  
docker build -t mcmillenchrisj/apcv_405_app:latest .  
docker run -p 9090:8080 mcmillenchrisj/apcv_405_app:latest  

Install and setup Jenkins:  
Go to https://www.jenkins.io/doc/book/installing/ for installation directions for your machine.  
After installation, go to http://localhost:8080 to setup Jenkins login credentials for admin user.  
Then go to plugins and install   

Create Jenkins pipeline:  
If you do not already have DockerHub credentials, create an account now.  
1. Go to "Manage Jenkins" then "Credentials" 
2. Click on "Add Credentials" then "Username with Password"
3. Ensure the scope is Global
4. Type in your DockerHub username and password/access token into the username and password fields.
5. Make the ID field: dockerhub-credentials
6. Then create, and go to the Jenkins dashboard
7. Click New Item
8. Name the item: devops-pipeline-project
9. Select "Pipeline" and click ok
10. In the job configuration, in the Pipeline section, there is a drop down menu, choose "Pipeline script from SCM"
11. Select Git in the SCM options
12. Type in the repository URL, https://github.com/mcmillenchrisj/apcv_405_app.git
13. Type in the branch: */main
14. The Script Path: JenkinsFile
15. Save Configuration

Start Pipeline:  
Now go to your Jenkins dashboard and click Build Now and monitor the progress of your application.

