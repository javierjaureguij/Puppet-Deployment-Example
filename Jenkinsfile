pipeline {
	agent any
	stages {
		stage("build") {
			steps {
				echo 'build'
				sh '''
					docker-compose build
				'''
			}
		}
		stage("test") {
			steps {
				echo 'test'
			}
		}
		stage("deploy") {
			steps {
				echo 'deploy'
				sh '''
					docker-compose up -d --force-recreate Suma
					docker-compose up -d --force-recreate SitioWeb
				''' 
			}
		}
	}
}