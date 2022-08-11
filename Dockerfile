FROM nginx:alpine

# add Dynatrace agent to alpine image
COPY --from=pwf40805.live.dynatrace.com/linux/oneagent-codemodules-musl:nginx / /

# Use this for non-alpine images
# COPY --from=pwf40805.live.dynatrace.com/linux/oneagent-codemodules:nginx / /

ENV LD_PRELOAD /opt/dynatrace/oneagent/agent/lib64/liboneagentproc.so
ENV DT_OPEN_TELEMETRY_ENABLE_INTEGRATION true