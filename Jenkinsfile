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
                    BUILD=${env.BUILD_ID}-1
		    echo "Pulling Wayshub Backend Repository"
                    cd ${dir}
                    docker container stop ${cont}
                    docker container rm ${img}:$BUILD-latest
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
	stage('Push Notification Discord') {
	   steps {
                sshagent([credential]){
		    discordSend description: "wayshub-backend:" + BUILD_ID, footer: "Kelompok 2 - Dumbways.id Devops Batch 13", link: BUILD_URL, result: currentBuild.currentResult, scmWebUrl: '', title: 'Wayshub-backend', webhookURL: 'https://discord.com/api/webhooks/1019867961349132379/f5XTPLZWgUBN3-QZ0E-OkFQPXOJrGdj0LOjHMsQA8jfYC9mL5W1bt60mc_UbpLi88ceM'
		}
	    }	
	}
    }
}
