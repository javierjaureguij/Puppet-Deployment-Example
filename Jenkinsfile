pipeline {
	agent any
	environment {
        DOCKERHUB_USER     = credentials('dockerhub_user')
        DOCKERHUB_PASSWORD = credentials('dockerhub_password')
		PUPPET_MASTER_URL  = '35.184.65.50'
		PUPPET_MASTER_HOME = '/home/jenkins'
		PUPPET_MASTER_MANIFEST_DIR = '/etc/puppet/code/environments/production/manifests'
		PUPPET_MASTER_DEV_FILES_DIR = '/etc/puppet/code/environments/production/modules/mymodule/files'
		PUPPET_MASTER_PROD_FILES_DIR = '/etc/puppet/code/environments/production/modules/mymodule/files'
    }
	stages {
		stage("BuildTests") {
			when {
				branch 'develop'
			}
			steps {
				echo 'Building tests...'
				sh '''
					docker-compose -f docker-compose-tests.yml down
					docker-compose -f docker-compose-tests.yml build
				'''
			}
		}
		stage("RunTests") {
			when {
				branch 'develop'
			}
			steps {
				echo 'Running tests...'
				sh '''
					docker-compose -f docker-compose-tests.yml up --exit-code-from SumaTest SumaTest
				'''
			}
		}
		stage("Build") {
			when {
				branch 'develop'
			}
			steps {
				echo 'Building docker images for deployment...'
				sh '''
					docker-compose down
					docker-compose build
				'''
			}
		}
		stage("PushBuilds") {
			when {
				branch 'develop'
			}
			steps {
				echo "Pushing docker images to DockerHub..."
				sh '''
					docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD
					docker-compose push
				'''
			}
		}
		stage("DeployDev") {
			when {
				branch 'develop'
			}
			steps {
				echo "Deploying to development..."
				sh '''
					echo "PORT_SITIO = 8081" > .env
					echo "New deployment" >> deployments.txt
					scp .env jenkins@${PUPPET_MASTER_URL}:${PUPPET_MASTER_HOME}/
					scp docker-compose.yml jenkins@${PUPPET_MASTER_URL}:${PUPPET_MASTER_HOME}/
					scp deployments.txt jenkins@${PUPPET_MASTER_URL}:${PUPPET_MASTER_HOME}/
					scp site.pp jenkins@{PUPPET_MASTER_URL}:${PUPPET_MASTER_HOME}/

					ssh jenkins@${PUPPET_MASTER_URL} sudo mv ${PUPPET_MASTER_HOME}/.env ${PUPPET_MASTER_DEV_FILES_DIR}/
					ssh jenkins@${PUPPET_MASTER_URL} sudo mv ${PUPPET_MASTER_HOME}/docker-compose.yml ${PUPPET_MASTER_DEV_FILES_DIR}/
					ssh jenkins@${PUPPET_MASTER_URL} sudo mv ${PUPPET_MASTER_HOME}/deployments.txt ${PUPPET_MASTER_DEV_FILES_DIR}/
					ssh jenkins@${PUPPET_MASTER_URL} sudo mv ${PUPPET_MASTER_HOME}/site.pp ${PUPPET_MASTER_MANIFEST_DIR}/

				'''
			}
		}
		stage("DeployProd") {
			when {
				branch 'master'
			}
			steps {
				echo 'Deploying to production...'
				sh '''
					echo "PORT_SITIO = 8082" > .env
				''' 
			}
		}
	}
}