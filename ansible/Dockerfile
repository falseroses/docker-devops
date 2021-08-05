FROM amazonlinux

RUN yum -y update
RUN amazon-linux-extras install ansible2 -y
RUN yum -y install curl unzip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install


RUN echo -e '#!/bin/bash\nans "$@"' > /usr/bin/ans && \
    chmod +x /usr/bin/ans

ENV AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
ENV AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
