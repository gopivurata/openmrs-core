pipeline {
    agent { label 'node' }
   // parameters {
   //  choice(name: 'branch', choices: ['master', 'SPRINT_1_DEV', 'my_branch'], description: 'branch delecting my choice')
  // }
    triggers { pollSCM('* * * * *') }
    stages {
        stage ('clone') {
            steps{
                      mail subject:  "$env.JOB_NAME build started",
                           body: "$env.JOB_NAME, $env.BUILD_ID build started",
                           to: 'gopivurata1992@gmail.com'
               // git branch: "${params.branch}",
                  git branch: 'SPRINT_1_DEV',
                      url: 'https://github.com/gopivurata/openmrs-core.git'
            }
        }
        stage ('sonarqube') {
            steps{
                withSonarQubeEnv('sonarqube') {
                    sh 'mvn clean package sonar:sonar'
                }
            }
        }/*
        stage ('sonar quality_gate') {
            steps {
                timeout(time: 20, unit: 'MINUTES'){
                    waitForQualityGate abortPipeline: true
                }
            }
        }*/
        stage ('upload packages to jfrog'){
            steps {
                rtUpload(
                serverId: 'MY_JFROG',
                spec: '''{
                    "files": [
                       {
                         "pattern": "./target/*.jar",
                         "target": "java-maven-libs-release"
                       }
                    ]
                }''',
                 // Optional - Associate the uploaded files with the following custom build name and build number,
                // as build artifacts.
                // If not set, the files will be associated with the default build name and build number (i.e the
                // the Jenkins job name and number).
                buildName: "$env.JOB_NAME",
                buildNumber: "$env.BUILD_ID",
                // Optional - Only if this build is associated with a project in Artifactory, set the project key as follows.
                project: 'openmrs'
            )
            }
        }
        stage ('artifacts publish') {
            steps {
                rtPublishBuildInfo (
                    serverId: 'MY_JFROG',
                   // buildName: "$env.JOB_NAME",
                   // buildNumber: "$env.BUILD_ID",
                   // project: 'openmrs'
                )
            }
        }/*
        stage ('jfrog_loging and docker image build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'JFrog', usernameVariable: 'jfrog_user_name', passwordVariable: 'jfrog_passwd')]) {
                    sh "docker login cdcd.jfrog.io -u ${jfrog_user_name} -p ${jfrog_passwd}"
                    sh "docker image build -t $env.JOB_NAME:$env.BUILD_ID ."
                    sh "docker image tag $env.JOB_NAME:$env.BUILD_ID cdcd.jfrog.io/docker/$env.JOB_NAME:$env.BUILD_ID"
                    sh "docker image push cdcd.jfrog.io/docker/$env.JOB_NAME:$env.BUILD_ID"
                }
            }
        }
        stage ('run the container') {
            steps {
                sh "docker container run -d -P --name openmrs cdcd.jfrog.io/docker/$env.JOB_NAME:$env.BUILD_ID"
            }
        }*/
    }
    post {
        always {
            echo 'completed job'
            mail subject: "Build completed for openmrs JOB $env.JOB_NAME",
                 body: "Build completed for openmrs JOB $env.JOB_NAME \n Click Here: $env.JOB_URL",
                 to: 'gopivurata1992@gmail.com'
        }
        failure {
            mail subject: "Build Faild for openmrs JOB $env.JOB_NAME with Build ID $env.BUILD_ID",
                 body: "Build Failed for openmrs JOB $env.JOB_NAME",
                 to: 'gopivurata1992@gmail.com'

        }
        success {
            junit '**/surefire-reports/*.xml'
        }


    }
}