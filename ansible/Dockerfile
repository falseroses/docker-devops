FROM amazonlinux

RUN yum -y update
RUN amazon-linux-extras install ansible2 -y
RUN yum -y install curl unzip tree nano
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install


RUN echo -e '#!/bin/bash\nans "$@"' > /usr/bin/ans && \
    chmod +x /usr/bin/ans

ENV ANSIBLE_HOST_KEY_CHECKING=False
ENV DEFAULT_HOST_LIST=/volumes/ansible-conf/hosts.txt
ENV INTERPRETER_PYTHON=auto_silent
ENV DEPRECATION_WARNINGS=False

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

WORKDIR ./volumes
