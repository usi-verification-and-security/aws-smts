################### Use SMTS
FROM smts-base AS builder
USER root

################### Extract SMTS in run stage
FROM satcomp-base:worker AS smts_liaison
WORKDIR /

# Copy smts
COPY --from=builder /SMTS smts
COPY --chown=ecs-user /worker /competition

RUN chmod +x /competition/worker
