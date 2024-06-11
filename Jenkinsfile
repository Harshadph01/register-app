pipeline {
	agent { label 'JEnkins-Agent' }
	tools {
		jdk 'Java17'
		maven 'Maven3'
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
	}
}
