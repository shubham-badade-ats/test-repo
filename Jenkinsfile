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
            sh "docker build -t shubhambadade07/test ."
            }
            }
        stage("docker tag "){
            steps{
            sh "docker image tag shubhambadade07/test:latest shubhambadade07/test:$BUILD_NUMBER "
            }
        }
        stage("docker login"){
            steps{
                
                sh "docker login -u shubhambadade07 -p Pass@12345"
            
            }
        }
        stage("push docker file"){
            steps{
                sh "docker push shubhambadade07/test:latest"
                sh "docker push shubhambadade07/test:$BUILD_NUMBER"
            }
        }
        stage('Check and Manage Container') {
            steps {
                 script {
                    // Check if the container exists
                    def containerExists = sh(script: 'docker ps -a --filter "name=test" --format "{{.Names}}" | grep "test"', returnStatus: true)

                    if (containerExists == 0) {
                        // Stop and remove the container if it exists
                        sh 'docker stop test'
                        sh 'docker rm test'
                        echo 'Container "test" stopped and removed.'
                    } else {
                        echo 'Container "test" is not present.'
                    }
                }
            }
        }
        stage("run Backend Container"){
            steps{
                sh 'docker run -d -p 8085:80 --name test shubhambadade07/test'
            }

        }
    }
}