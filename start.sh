#!/bin/bash
# Bash Menu Script Example

PS3='Choose Docker Image: '
options=("Ansible" "Terraform" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Ansible")
            docker build -t ansible:latest ansible/
            docker run -v $PWD/ansible/ansible-conf/:/volumes/ansible-conf -it ansible:latest
            ;;
        "Terraform")
            echo "you chose choice 2"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
