def branch = "main"
def rname = "origin"
def dir = "~/wayshub-backend/"
def credential = 'appserver'
def server = 'kel2@103.183.74.32'
def img = 'ivankalan12/wayshub-be'
def cont = 'wayshub-be'


pipeline {
    agent any

    stages {
        stage('Repository Pull') {
            steps {
                sshagent([credential]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        echo "Pulling Wayshub Backend Repository"
                        cd ${dir}
                        docker container stop ${cont}
                        git pull ${rname} ${branch}
                        exit
                    EOF"""
                }
            }
        }
            
        stage('Building Docker Image') {
            steps {
                sshagent([credential]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        echo "Building Image"
                        cd ${dir}
                        docker build -t ${img}:${env.BUILD_ID} .
			exit
                    EOF"""
                }
            }
        }
            
        stage('Image Deployment') {
            steps {
                sshagent([credential]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${dir}
                        docker tag ${img}:${env.BUILD_ID} ${img}:${env.BUILD_ID}-latest
			docker container run ${contdb}
                        docker container run ${cont}
			exit
                    EOF"""
                }
            }
        }
        
        stage('Pushing to Docker Hub (ivankalan12)') {
            steps {
                sshagent([credential]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${dir}
                        docker image push ${img}:${env.BUILD_ID}-latest
			exit
                    EOF"""
                }
            }
        }
    }
}
