#!/bin/bash

read -p "Type your AWS_ACCESS_KEY_ID: "

echo "AWS_ACCESS_KEY_ID=$REPLY" > aws-credentials

read -p "Type your AWS_SECRET_ACCESS_KEY: "

echo "AWS_SECRET_ACCESS_KEY=$REPLY" >> aws_credentials

echo "Succefully saved your AWS Credentials!"
