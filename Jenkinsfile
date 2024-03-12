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
    post {
 always {
 script {
 def jobName = env.JOB_NAME
 def buildNumber = env.BUILD_NUMBER
 def pipelineStatus = currentBuild.result ?: 'UNKNOWN'
 def bannerColor = pipelineStatus.toUpperCase() == 'SUCCESS' ? 'green' : 
'red'
 
 def body = """<html>
 <body>
 <div style="border: 4px solid ${bannerColor}; padding: 
10px;">
 <h2>${jobName} - Build ${buildNumber}</h2>
 <div style="background-color: ${bannerColor}; padding: 
10px;">
 <h3 style="color: white;">Pipeline Status: 
${pipelineStatus.toUpperCase()}</h3>
 </div>
 <p>Check the <a href="${BUILD_URL}">console 
output</a>.</p>
 </div>
 </body>
 </html>"""
 emailext (
 subject: "${jobName} - Build ${buildNumber} - ${pipelineStatus.toUpperCase()}",
 body: body,
 to: 'shubhambadade007@gmail.com',
 from: 'shubhambadade.ats454@gmail.com',
 replyTo: 'jenkins@example.com',
 mimeType: 'text/html',
 
 )
 }
 }
    }
}
