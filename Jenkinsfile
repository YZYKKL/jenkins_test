pipeline {
    agent any

    stages {
        stage('git') {
            steps {
                git branch: 'main', credentialsId: 'f349f99d-aa5a-47fd-93ea-269a97ed119b', url: 'git@github.com:YZYKKL/jenkins_test.git'
                echo 'Hello World'
            }
        }
    }
}
