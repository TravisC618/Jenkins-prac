pipeline {
	agent {
		dockerfile true
	}
	environment {
		AUTH0_CLIENT_ID='ad87ad@dna*dahkudh2'
		AUTH0_SECRET='ad87ad@dna*dahkudh2'
	}
	stages {
		stage('Test dockerfile') {
			steps {
				sh 'echo DOCKER_ENV = $DOCKER_ENV'
			}
		}
		stage('Build') {
			steps {
				echo '===========Building==========='
				echo 'AUTH0_CLIENT_ID = $AUTH0_CLIENT_ID'
				echo 'AUTH0_SECRET = $AUTH0_SECRET'
			}
		}
	}
}