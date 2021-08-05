FROM amazonlinux

RUN yum -y update
RUN yum -y install wget unzip
ARG TER_VER
RUN wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
RUN unzip terraform_${TER_VER}_linux_amd64.zip
RUN mv terraform /usr/local/bin/
