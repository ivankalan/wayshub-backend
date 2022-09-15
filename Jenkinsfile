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
        stage('Generate Remote') {
            steps {
                sshagent([credential]){
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        echo "Generating git remote"
                        cd ${dir}
                        git config --global user.name ivankalan
			git config --global user.email ivankalanv2.1@gmail.com
			ssh -T git@github.com
                        exit
                    EOF"""
                }
            }
        }
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
                        docker container run -d ${cont}
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
  discordSend description: '', footer: '', image: '', link: 'env.BUILD_URL', result: 'SUCCESS|UNSTABLE|FAILURE|ABORTED', scmWebUrl: '', thumbnail: '', title: 'env.JOB_NAME', webhookURL: 'https://discord.com/api/webhooks/1019867961349132379/f5XTPLZWgUBN3-QZ0E-OkFQPXOJrGdj0LOjHMsQA8jfYC9mL5W1bt60mc_UbpLi88ceM'
}
