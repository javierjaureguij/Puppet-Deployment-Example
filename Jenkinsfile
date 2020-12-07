pipeline {
	agent any
	stages {
		stage("build") {
			steps {
				docker ps
				echo 'build'
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
			}
		}
	}
}