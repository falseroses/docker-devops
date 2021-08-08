#!/bin/bash

FILE=aws_credentials
if [ ! -f "$FILE" ]; then
    echo -e "\033[1mYOU NEED TO SET YOUR AWS CREDENTIALS!\033[0m"
fi
PS3='Choose Docker Image: '
options=("Ansible" "Terraform" "Set AWS Credentials" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Ansible")
            source aws_credentials 2>/dev/null
            docker build -t ansible:latest ansible/ --build-arg AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} --build-arg AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
            docker run -v $PWD/ansible/ansible-conf/:/volumes/ansible-conf -v $PWD/ansible/ssh-key/:/volumes/ssh-key -it ansible:latest
            break
            ;;
        "Terraform")
            source aws_credentials 2>/dev/null
            docker build -t terraform:latest terraform/ --build-arg AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} --build-arg AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
            docker run -v $PWD/terraform/terraform-conf/:/volumes/terraform-conf -v $PWD/terraform/ssh-key/:/volumes/ssh-key -it terraform:latest
            break
            ;;
        "Set AWS Credentials")
            read -p "Type your AWS_ACCESS_KEY_ID: "
            echo "AWS_ACCESS_KEY_ID=$REPLY" > aws_credentials
            read -p "Type your AWS_SECRET_ACCESS_KEY: "
            echo "AWS_SECRET_ACCESS_KEY=$REPLY" >> aws_credentials
            echo -e "\033[1mSuccefully saved your AWS Credentials!\033[0m"
            ./start_docker_containers.sh
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
