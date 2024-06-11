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
		stage('Build & Push Docker Image') {
  			steps {
  				  script {
    					  // Check script existence and permissions
     					 if (!fileExists('docker_push.sh') || !hasPermission(file: 'docker_push.sh', permission: 'EXECUTE')) {
     						   error 'docker_push.sh script missing or not executable!'
     						 }
      
   					   sh './docker_push.sh' // Assuming the script is in the same directory
   				 }
			  }
		}

	}
}
