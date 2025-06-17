pipeline {
    agent {
        docker {
            image 'node:18-alpine'
            args '-p 3000:3000'
        }
    }
    
    environment {
        CI = 'true'
        AWS_REGION = 'ap-southeast-1'  // เปลี่ยนเป็น region ที่ใช้
        S3_BUCKET = 'my-react-static-website-12345'  // เปลี่ยนเป็นชื่อ bucket ที่สร้างด้วย Terraform
        AWS_CREDENTIALS = 'aws-credentials'  // ID ของ credentials ที่ตั้งค่าใน Jenkins
    }
    
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm ci'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh 'npm test -- --watchAll=false'
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        
        stage('Deploy to S3') {
            steps {
                withAWS(region: "${AWS_REGION}", credentials: "${AWS_CREDENTIALS}") {
                    sh 'aws s3 sync build/ s3://${S3_BUCKET}/ --delete'
                }
            }
        }
        
        stage('Invalidate CloudFront Cache') {
            steps {
                echo 'Skipping CloudFront cache invalidation for now'
                // หากมีการใช้ CloudFront สามารถเพิ่มคำสั่งสำหรับ invalidate cache ได้ที่นี่
            }
        }
    }
    
    post {
        success {
            echo 'Deployment completed successfully!'
            echo 'Website URL: http://${S3_BUCKET}.s3-website-${AWS_REGION}.amazonaws.com'
        }
        failure {
            echo 'Build or deployment failed!'
        }
    }
}
