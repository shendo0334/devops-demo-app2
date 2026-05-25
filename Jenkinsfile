pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-2'
        APPLICATION_NAME = 'AV-FlaskMicroserviceApp'
        DEPLOYMENT_GROUP = 'AV-FlaskDG'
        S3_BUCKET = 'flask-cicd-artifacts-av'
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/shendo0334/devops-demo-app2.git'
            }
        }

        stage('Create Deployment Package') {
            steps {
                sh 'zip -r deployment.zip .'
            }
        }

        stage('Upload to S3') {
            steps {
                withAWS(credentials: 'aws-jenkins', region: 'ap-south-2') {
                    sh '''
                    aws s3 cp deployment.zip s3://$S3_BUCKET/deployment.zip
                    '''
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                withAWS(credentials: 'aws-jenkins', region: 'ap-south-2') {
                    sh '''
                    aws deploy create-deployment \
                    --application-name $APPLICATION_NAME \
                    --deployment-group-name $DEPLOYMENT_GROUP \
                    --s3-location bucket=$S3_BUCKET,bundleType=zip,key=deployment.zip
                    '''
                }
            }
        }
    }
}