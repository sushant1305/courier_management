pipeline {
	options {
    buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
	}
    /* agent { docker { image 'node:20.9.0-alpine3.18' } } */
    agent any
    stages {
        stage('Build Image') {
            steps {
                echo 'Starting to build ${JOB_NAME}'
                script {
                    def app = docker.build("courier_mgmt:${env.BUILD_ID}")
                }
            }  
        }
        stage('sonar-scanner') {
            steps {
                withSonarQubeEnv('Sonarqube') {
                    sh "${tool('sonar-scanner')}/bin/sonar-scanner -Dsonar.token=sqa_75a473269119e26cd79c57c9feda56893613c7a9 -Dsonar.projectKey=dissertation -Dsonar.projectName=courier_mgmt -Dsonar.sources=app.js -Dsonar.projectVersion=${BUILD_NUMBER}"
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
        
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
    }
}

