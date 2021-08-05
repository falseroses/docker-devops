FROM amazonlinux

RUN yum -y update
RUN yum -y install wget unzip tree nano
ARG TER_VER
RUN wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
RUN unzip terraform_${TER_VER}_linux_amd64.zip
RUN mv terraform /usr/local/bin/


ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}


RUN echo -e '#!/bin/bash\nterraform "$@"' > /usr/bin/tf && \
    chmod +x /usr/bin/tf
