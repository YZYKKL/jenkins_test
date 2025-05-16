pipeline {
    agent any
    environment {
        harborUser = "admin"
        harborPasswd = "Harbor12345"
        harborHostname = "harbormytest.com"
        harborRepo = "library"
        tag = "main"          // 定义tag
    }
    stages {
        stage('git') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: "refs/heads/${env.tag}"]],
                    userRemoteConfigs: [[credentialsId: 'testtest', url: 'git@github.com:YZYKKL/jenkins_test.git']]
                ])
                echo 'Git finish'
            }
        }
        stage('build docker image') {
            steps {
                sh "docker build -t ${env.JOB_NAME}:${env.tag} ."
                echo 'Build docker image finish'
            }
        }
        stage('Push docker image') {
            steps {
                sh """
                    docker login ${env.harborHostname} -u ${env.harborUser} -p ${env.harborPasswd}
                    docker tag ${env.JOB_NAME}:${env.tag} ${env.harborHostname}/${env.harborRepo}/${env.JOB_NAME}:${env.tag}
                    docker push ${env.harborHostname}/${env.harborRepo}/${env.JOB_NAME}:${env.tag}
                """
                echo 'Push docker image finish'
            }
        }
    }
}
