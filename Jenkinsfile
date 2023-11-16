pipeline {
	options {
    buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
	}
    /* agent { docker { image 'node:20.9.0-alpine3.18' } } */
    agent { label 'controlleragent' }
    stages {
        stage('Build Image') {
            steps {
                echo 'Starting to build ${JOB_NAME}'
                script {
                    def app = docker.build("courier_mgmt:${env.BUILD_ID}")
                }
            }  
        }
        
        stage('Tag Image') {
            steps {
                echo 'Tag ${JOB_NAME} Image'
                script {
                        sh "docker tag courier_mgmt:${env.BUILD_ID} 192.168.0.130:5000/courier_mgmt:latest"
                }
            }
        }
        stage('Publish Image') {
            steps {
                echo 'Publishing ${JOB_NAME}'
                script {
                        sh "docker push 192.168.0.130:5000/courier_mgmt:latest"
                }
            }
        }  
        
        stage('Proceed to Deployment'){
            steps{
                echo 'Wating for approval'
                script{
                    input 'Deploy'
                }
            }
        }

        stage('Deploy'){
            steps{
                echo 'Proceeding with deployment'
                script{
                    sh "ansible-playbook --vault-password-file=.ansible_vault.password -v -i /home/cddeploy/ansible/infrastructure/inventory/hosts.ini --tags deploy DEPLOY/deploy_app.yml"
                }
            }

        }
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
    }
}

