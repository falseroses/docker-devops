FROM amazonlinux

RUN yum -y update
RUN yum -y install wget unzip tree nano git tar
RUN wget https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.7.linux-amd64.tar.gz
ENV PATH=/usr/local/go/bin:$PATH
RUN git clone https://github.com/hashicorp/terraform.git && cd terraform && go install
RUN mv ~/go/bin/terraform /usr/local/bin/

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}


RUN echo -e '#!/bin/bash\nterraform "$@"' > /usr/bin/tf && \
    chmod +x /usr/bin/tf

WORKDIR /volumes
