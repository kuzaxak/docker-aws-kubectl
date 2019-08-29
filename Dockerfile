FROM python:alpine
MAINTAINER Vladimir Kuznichenkov <kuzaxak.tech@gmail.com>

ADD https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.4.0/aws-iam-authenticator_0.4.0_linux_amd64 /usr/local/bin/aws-iam-authenticator

RUN apk --no-cache add curl jq \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
	&& mv kubectl /usr/local/bin \
	&& chmod +x /usr/local/bin/kubectl \
  && pip install --upgrade awscli \
  && aws --version \
  && kubectl version --client

RUN adduser -S user
USER user

ENTRYPOINT ["/usr/local/bin/kubectl"]
