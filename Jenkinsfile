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
				sh '''
					docker-compose up --exit-code-from SumaTest SumaTest
				'''
			}
		}
		stage("deploy") {
			steps {
				echo 'deploy'
				sh '''
					docker-compose up -d Suma
					docker-compose up -d Sitioweb
				''' 
			}
		}
	}
}