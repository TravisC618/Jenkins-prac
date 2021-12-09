podTemplate(
    containers: [
        containerTemplate(image: 'docker', name: 'docker', command: 'cat', ttyEnabled: true),
        containerTemplate(image: 'mini/eb-cli', name: 'eb', command: 'cat', ttyEnabled: true)
    ],
    volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]
) {
    node(POD_LABEL) {
        
        def image
        withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USER', passwordVariable: 'PASSWD')]) {
            image = "${USER}/devopsv5:${currentBuild.number}"
        }

        stage("Docker image build") {
			checkout scm
            dockerImageBuild("${image}")
        }
        
        stage("Docker image push") {
            dockerImagePUSH("${image}")
        }
        
        stage("Deploy to Test environment"){
            deployToEB("test");
        }
        
        stage("Running test on test environment") {
            smokeTest("test")
        }
    }
}

def dockerImageBuild(image) {
    container('docker') {
        sh "docker build -t ${image} ."
    }
}

def dockerImagePUSH(image) {
    withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USER', passwordVariable: 'PASSWD')]) {
        container('docker') {
            sh "docker login --username ${USER} --password ${PASSWD}"
            sh "docker push ${image}"   
        }
    }
}

def deployToEB(env) {
    withCredentials([usernamePassword(credentialsId: 'aws-eb-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
        container('eb') {
            withEnv(["AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}", "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}", "AWS_REGION=us-east-1", "AWS_EB_ENV_NAME=Devopsv5-env"]) {
                dir("deployment") {
                    sh "echo aws eb env name: ${AWS_EB_ENV_NAME}"
					sh "cat Dockerrun.aws.json.tpl"
                    // sh "eb deploy ${AWS_EB_ENV_NAME}"   
                }
            }
        }        
    }
}

def smokeTest(env) {
    sh 'echo "...running smoke test on ${env} environment..."'
}
