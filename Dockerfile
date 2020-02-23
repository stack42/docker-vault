FROM debian:stable-slim AS builder

ENV VAULT_VERSION=1.3.2

WORKDIR /

RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  && rm -rf /var/lib/apt/lists/* &&\
  wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip  &&\
  unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /

# Second stage.

FROM debian:stable-slim

WORKDIR /

COPY --from=builder /vault /

ENTRYPOINT ["./vault"]

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/stack42/docker-vault"
