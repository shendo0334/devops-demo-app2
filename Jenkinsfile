pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-2'
        APPLICATION_NAME = 'FlaskMicroserviceApp'
        DEPLOYMENT_GROUP = 'FlaskDG'
        S3_BUCKET = 'YOUR_BUCKET_NAME'
    }

    stages {

        stage('Create Deployment Package') {
            steps {
                sh 'zip -r deployment.zip . -x "*.git*"'
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
