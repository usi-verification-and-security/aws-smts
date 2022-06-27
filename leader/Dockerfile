################### Use smts
FROM smtscq-base AS builder
USER root


################### Extract SMTS in run stage
FROM satcomp-base:leader AS smts_liaison
WORKDIR /

# Copy smts and solver scripts
COPY --from=builder /SMTS smts
COPY --chown=ecs-user /run_smts.sh /competition
COPY --chown=ecs-user /solver /competition
USER ecs-user
RUN chmod +x /competition/run_smts.sh
RUN chmod +x /competition/solver