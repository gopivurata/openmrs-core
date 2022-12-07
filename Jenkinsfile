

pipeline {
    agent any
    stages {
        stage ('git clone') {
            steps {
                git branch: 'master', 
                    url: 'https://github.com/gopivurata/openmrs-core.git'
            }
        }
        stage ('docker image build') {
            steps {
                sh 'cd openmrs-core'
                sh 'docker image build -t open-mrs:1.0 .'
                sh 'docker container run --name my-mrs -d -P open-mrs:1.0'
            }
        }
    }
