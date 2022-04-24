pipeline {
  agent any
  options {
        ansiColor("xterm")
    }
  stages {
    stage ('Packer Deploy') {
      steps {
        withCredentials([gitUsernamePassword(credentialsId: 'von-salumbides',
          gitToolName: 'git-tool')]) {
          sh "make ${PKR_CMD}"
        }
        script {
          env.AMI_ID=sh(script: 'jq -r ".builds[-1].artifact_id" manifest.json | cut -d ":" -f2', returnStdout: true).trim()
          currentBuild.displayName = "${PKR_CMD}"
        }
      }
    }
    stage('Launch Template Update') {
      steps {
        sh "printenv"
      }
    }
  } 
  post {
    always {
      cleanWs()
    }
  }
}