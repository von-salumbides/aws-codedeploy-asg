pipeline {
  agent any 
  options {
    ansiColor("xterm")
    withAWS(credentials: 'AWS_ACCESS_KEY_ID', region: 'us-east-2')
  }
  stages {
    stage("Deploy") {
      environment {
        CODEDEPLOY_APP_NAME   = "devops-poc"
        CODEDEPLOY_GROUP_NAME = "devops-poc"
        CODEDEPLOY_S3_BUCKET  = "devops-poc-bucket"
        AWS_ACCOUNT_ID        = "${AWS_ACCOUNT_ID}"
        AWS_ACCOUNT_ROLE      = "${AWS_ACCOUNT_ROLE}"
      }
      steps {
        script {
          try {
            if ( "${ROLL_BACK}" == "no" ) {
              zip dir: "./", zipFile: "artifacts/${VERSION_TAG}.zip"
              s3Upload acl: 'Private', file: "artifacts/${VERSION_TAG}.zip", bucket: "${CODEDEPLOY_S3_BUCKET}", path: "artifacts/${VERSION_TAG}.zip"
            }
            DEPLOY_ID = createDeployment(
              s3Bucket: "${CODEDEPLOY_S3_BUCKET}",
              s3Key: "artifacts/${VERSION_TAG}.zip",
              s3BundleType: 'zip', // [Valid values: tar | tgz | zip | YAML | JSON]
              applicationName: "${CODEDEPLOY_APP_NAME}",
              deploymentGroupName: "${CODEDEPLOY_GROUP_NAME}",
              deploymentConfigName: 'CodeDeployDefault.AllAtOnce',
              description: "Deployment Version ${VERSION_TAG}",
              waitForCompletion: 'true',
              ignoreApplicationStopFailures: 'false',
              fileExistsBehavior: 'OVERWRITE'
            )
            echo "${DEPLOY_ID}"
          }
            catch(e){
              sh "printenv"
              println(e)
            throw e
          }
        }
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}