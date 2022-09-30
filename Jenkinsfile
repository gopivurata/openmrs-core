pipeline {
    agent  { label 'node-1' }
    stages {
        stage('git') {
            steps {
                git branch: 'my_master', 
                url: 'https://github.com/gopivurata/openmrs-core.git'
            }

        }
        stage('build') {
            steps {
                sh '/usr/share/maven/bin/mvn package'
            }
        }
        stage('archive results') {
            steps {
                junit '**/surefire-reports/*.xml'
            }
        }
    }

}