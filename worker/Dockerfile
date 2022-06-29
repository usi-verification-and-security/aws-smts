################### Use SMTS
FROM smtsp-base AS builder
USER root

################### Extract SMTS in run stage
FROM satcomp-base:worker AS smts_liaison
USER root
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt install -y apt-utils \
     build-essential libgmp-dev bison flex

WORKDIR /

# Copy smts
COPY --from=builder /SMTS SMTS
COPY --chown=ecs-user /worker /competition

RUN chmod +x /competition/worker
