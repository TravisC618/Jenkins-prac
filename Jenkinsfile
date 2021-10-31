pipeline {
	agent any
	environment {
		AUTH0_CLIENT_ID='ad87ad@dna*dahkudh2'
		AUTH0_SECRET='ad87ad@dna*dahkudh2'
	}
	stages {
		stage('Test Env Var') {
			steps {
				echo 'AUTH0_CLIENT_ID = $AUTH0_CLIENT_ID'
				echo 'AUTH0_SECRET = $AUTH0_SECRET'
			}
		}
		stage('Build') {
			steps {
				echo '===========Building==========='
				sh 'docker build -t travisccc/easycrm .'
			}
		}
		stage('Run') {
			steps {
				echo '===========Run==========='
				sh 'docker run -p 8090:8090 travisccc/easycrm'
			}
		}
	}
}