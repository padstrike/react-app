#!/bin/bash

# Script สำหรับ build และ deploy React app ไปยัง S3
# ต้องมีการตั้งค่า AWS credentials ก่อนใช้งาน script นี้

# ตัวแปรสำหรับการตั้งค่า
BUCKET_NAME="my-react-static-website-12345"  # เปลี่ยนเป็นชื่อ bucket ที่สร้างด้วย Terraform
REGION="ap-southeast-1"  # เปลี่ยนเป็น region ที่ใช้

# Build React app
echo "Building React application..."
npm run build

# ตรวจสอบว่า build สำเร็จหรือไม่
if [ $? -ne 0 ]; then
  echo "Build failed!"
  exit 1
fi

# Deploy ไปยัง S3
echo "Deploying to S3 bucket: $BUCKET_NAME"
aws s3 sync build/ s3://$BUCKET_NAME/ --delete --region $REGION

# ตรวจสอบว่า deploy สำเร็จหรือไม่
if [ $? -ne 0 ]; then
  echo "Deployment failed!"
  exit 1
fi

# แสดง URL ของเว็บไซต์
echo "Deployment successful!"
echo "Website URL: http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"
