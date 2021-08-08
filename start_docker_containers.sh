#!/bin/bash

if [ ! -f credentials/aws_credentials ]; then
    echo -e "\033[1mWARNING: YOU NEED TO SET YOUR AWS CREDENTIALS!\033[0m"
fi
if [ ! -f credentials/ssh-key/*.pem ]; then
    echo -e "\033[1mWARNING: YOU NEED TO SET YOUR SSH KEY OR PLACE IT IN CREDENTIALS/SSH-KEY FOLDER!\033[0m"
fi
PS3='Choose Docker Image: '
options=("Ansible" "Terraform" "Set AWS Credentials" "Set SSH Key" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Ansible")
            source credentials/aws_credentials 2>/dev/null
            docker build -t ansible:latest ansible/ --build-arg AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} --build-arg AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
            docker run -v $PWD/ansible/ansible-conf/:/volumes/ansible-conf -v $PWD/credentials/ssh-key/:/volumes/ssh-key -it ansible:latest
            break
            ;;
        "Terraform")
            source credentials/aws_credentials 2>/dev/null
            docker build -t terraform:latest terraform/ --build-arg AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} --build-arg AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
            docker run -v $PWD/terraform/terraform-conf/:/volumes/terraform-conf -v $PWD/credentials/ssh-key/:/volumes/ssh-key -it terraform:latest
            break
            ;;
        "Set AWS Credentials")
            read -p "Type Your AWS_ACCESS_KEY_ID: "
            echo "AWS_ACCESS_KEY_ID=$REPLY" > credentials/aws_credentials
            read -p "Type Your AWS_SECRET_ACCESS_KEY: "
            echo "AWS_SECRET_ACCESS_KEY=$REPLY" >> credentials/aws_credentials
            echo -e "\033[1mSUCCESSFULLY SAVED YOUR AWS CREDENTIALS!\033[0m"
            ./start_docker_containers.sh
            break
            ;;
        "Set SSH Key")
            read -p "Type Path to Your SSH Key: " -e path
            if cp $path credentials/ssh-key ; then
                echo -e "\033[1mSUCCESSFULLY SAVED YOUR SSH KEY!\033[0m"
            else
                echo -e "\033[1mERROR: SOMETHING WENT WRONG.\033[0m"
            fi
            ./start_docker_containers.sh
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid Option $REPLY";;
    esac
done
