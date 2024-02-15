pipeline {
    agent any
  
    stages{
        stage("clone repo"){
            steps{
               git branch: 'main', url: 'https://github.com/shubham-badade-ats/test-repo.git'
            }
        }
    
        stage("build docker file"){
            steps{
            bat "docker build -t shubhambadade07/test ."
            }
            }
        stage("docker tag "){
            steps{
            bat "docker image tag shubhambadade07/test:latest shubhambadade07/test:$BUILD_NUMBER "
            }
        }
        stage("docker login"){
            steps{
                
                bat "docker login -u shubhambadade07 -p Pass@12345"
            
            }
        }
        stage("push docker file"){
            steps{
                bat "docker push shubhambadade07/test:latest"
                bat "docker push shubhambadade07/test:$BUILD_NUMBER"
            }
        }
        stage('Check and Manage Container') {
            steps {
                script {
                    // Check if the container exists
                    def containerExists = bat(returnStatus: true, script: 'docker ps -a --filter "name=test" --format "{{.Names}}" | findstr /r "test"')
                    if (containerExists == 0) {
                        // Stop and remove the container if it exists
                        bat 'docker stop test'
                        bat 'docker rm test'
                        echo 'Container "test" stopped and removed.'
                    } else {
                        echo 'Container "test" is not present.'
                    }
                }
            }
        }
        stage("run Backend Container"){
            steps{
                bat 'docker run -d -p 8085:80 --name test shubhambadade07/test'
            }

        }
    }
}