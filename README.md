# Dynatrace setup

## Export the Environment Variables

```bash
export DT_TENANT="your_tenant"
export DT_CLUSTER_ID=-"your_cluster_id"
export DT_CONNECTION_BASE_URL="https://$DT_TENANT.live.dynatrace.com"
export DT_CONNECTION_AUTH_TOKEN="your_connection_auth_token"
```

Other useful Environment Variables are:

```bash
export DT_PAAS_TOKEN="your_paas_token"
export DT_TECHNOLOGY="all" # Valid options: all, java, apache, nginx, nodejs, dotnet, php, go, sdk
```

## Docker login

You need to be logged in to download the Dynatrace agent from inside the container.

```echo ${DT_PAAS_TOKEN} | docker login -u ${DT_TENANT} --password-stdin ${DT_TENANT}.live.dynatrace.com```

## Create the Dockerfile

```Dockerfile
FROM nginx:alpine

# add Dynatrace agent to alpine image
COPY --from=your_tenant.live.dynatrace.com/linux/oneagent-codemodules-musl:nginx / /

# Use this for non-alpine images
# COPY --from=your_tenant.live.dynatrace.com/linux/oneagent-codemodules:nginx / /

ENV LD_PRELOAD /opt/dynatrace/oneagent/agent/lib64/liboneagentproc.so
ENV DT_OPEN_TELEMETRY_ENABLE_INTEGRATION true
```

## Build the container image

```docker build -t nginx-dynatrace -f Dockerfile .```

## Run and test

```bash
docker run --name nginx-dynatrace -d \
    -e DT_TENANT=$DT_TENANT \
    -e DT_CLUSTER_ID=$DT_CLUSTER_ID \
    -e DT_CONNECTION_BASE_URL=$DT_CONNECTION_BASE_URL \
    -e DT_CONNECTION_AUTH_TOKEN=$DT_CONNECTION_AUTH_TOKEN \
    -p 80:80
    nginx-dynatrace
```
