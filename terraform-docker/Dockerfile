FROM amazonlinux

RUN yum -y update
RUN yum-config-manager --add-repo https://rpm.releases.hashicorp.com/$release/hashicorp.repo
RUN yum -y install terraform
