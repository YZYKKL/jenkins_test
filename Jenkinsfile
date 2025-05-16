pipeline {
    agent any
    environment{
        harborUser = "admin"
        harborPasswd = "Harbor12345"
        harborHostname = "harbormytest.com"
        harborRepo = "library"
    }
    stages {
        stage('git') {
            steps {
                checkout scmGit(branches: [[name: '*/$(tag)']], extensions: [], userRemoteConfigs: [[credentialsId: 'testtest', url: 'git@github.com:YZYKKL/jenkins_test.git']])
                echo 'Git finish'
            }
        }
        stage('build docker image') {
            steps {
                sh 'docker build -t $(JOB_NAME):$(tag)'
                echo 'Build docker image finish'
            }
        }
        stage('Push docker image') {
            steps {
                sh '''docker login $(harborHostname) -u $(harborUser) -p $(harborPasswd)
docker tag ${JOB_NAME}:${tag} $(harborHostname)/$(harborRepo)/${JOB_NAME}:${tag}
docker push $(harborHostname)/$(harborRepo)/${JOB_NAME}:${tag}'''
                echo 'Push docker image finish'
            }
        }
    }
}
