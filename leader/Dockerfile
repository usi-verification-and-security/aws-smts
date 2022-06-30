################### Use smts
FROM csmtsp-base AS builder
USER root

################### Extract SMTS in run stage
FROM satcomp-base:leader AS smts_liaison
USER root
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt install -y apt-utils \
     build-essential libgmp-dev bison flex

WORKDIR /

# Copy smts and solver scripts
COPY --from=builder /SMTS SMTS
COPY --chown=ecs-user /run_smts.sh /competition
COPY --chown=ecs-user /solver /competition
USER ecs-user
RUN chmod +x /competition/run_smts.sh
RUN chmod +x /competition/solver