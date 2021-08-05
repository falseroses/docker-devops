#!/bin/bash

PS3='Choose Docker Image: '
options=("Ansible" "Terraform" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Ansible")
            docker build -t ansible:latest ansible/
            docker run -v $PWD/ansible/ansible-conf/:/volumes/ansible-conf -v $PWD/ansible/ssh-key/:/volumes/ssh-key -it ansible:latest
            break
            ;;
        "Terraform")
            docker build -t terraform:latest terraform/ --build-arg TER_VER=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'`
            docker run -v $PWD/ansible/ansible-conf/:/volumes/terraform-conf -v $PWD/terraform/ssh-key/:/volumes/ssh-key -it terraform:latest
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
