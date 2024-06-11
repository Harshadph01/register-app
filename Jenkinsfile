pipeline {
	agent { label 'Jenkins-Agent' }
	tools {
		jdk 'Java17'
		maven 'Maven3'
	}
	environment {
		APP_NAME = "register-app-pipeline"
		RELEASE = "1.0.0"
		DOCKER_USER = "harshadph01"
		DOCKER_PASS = 'dckr_pat_Otrv6Dzdnn4uvKZtp_TUlnGN61Q'
		IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
		IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
	}
	stages{
		stage("Cleanup Workspace"){
			steps {
			cleanWs()
			}
		}
		
		stage("checkout from SCM"){
			steps {
			git branch: 'main', credentialsId: 'github', url: 'https://github.com/Harshadph01/register-app.git'
			}
		}
		stage ("Build Application"){
			steps {
				sh 'mvn clean package'
			}
		}
		stage ("Test Application"){
			steps {
				sh "mvn test"
			}
		}
		stage("SonarQube Analysis"){
			steps {
				script {
					withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token'){
					sh "mvn sonar:sonar"
					}
				}
			}
		}
		stage ("Quality Gate"){
			steps {
				script {
					waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-sonarqube-token'
				}
			}
		}
		stage("Build & Push Docker Image"){
 			 steps {
  				  script {
    					  def dockerUsername = env.DOCKER_USER
    					  def dockerPassword = env.DOCKER_PASS
      
     					 // Login to Docker Hub
      					sh "docker login -u $dockerUsername -p $dockerPassword"
      
     					 docker.withRegistry('https://hub.docker.com', '') {
      						 docker_image = docker.build "${IMAGE_NAME}:${IMAGE_TAG}"
       						 docker_image.push() // Push the tagged image
       						 docker_image.push('latest') // Push the 'latest' tag
     					 }
   				 }
 			 }
		}

	}
}
