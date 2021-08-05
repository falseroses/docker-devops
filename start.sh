#!/bin/bash

source aws_credentials
echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY
PS3='Choose Docker Image: '
options=("Ansible" "Terraform" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Ansible")
            docker build -t ansible:latest ansible/ --build-arg AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} --build-arg AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
            docker run -v $PWD/ansible/ansible-conf/:/volumes/ansible-conf -v $PWD/ansible/ssh-key/:/volumes/ssh-key -it ansible:latest
            break
            ;;
        "Terraform")
            docker build -t terraform:latest terraform/ --build-arg TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'` --build-arg AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} --build-arg AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
            docker run -v $PWD/terraform/terraform-conf/:/volumes/terraform-conf -v $PWD/terraform/ssh-key/:/volumes/ssh-key -it terraform:latest
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
