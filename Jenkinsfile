pipeline{
    agent { label ' NODE-1' }
    stages {
        stage(vcs) {
            steps {
                git branch: 'SPRINT_1_DEV',
                url: 'https://github.com/gopivurata/openmrs-core.git'
            }
        }
        stage(build) {
            steps {
                sh 'usr/share/maven/bin/mvn package'
            }
        }
        stage(archive results) {
            steps {
                junit '**/target/*.xml'
            }
        }
        stage(artifacts) {
            archiveArtifacts artifacts: '**/target/*.jar'
        }
    }
}