# docker-autoheal
THIS IS A FORK OF https://github.com/willfarrell/docker-autoheal



Monitor and restart unhealthy docker containers. 

## How to use
a) Apply the label `autoheal=true` to your container to have it watched.

b) Set ENV `AUTOHEAL_CONTAINER_LABEL=all` to watch all running containers. 

c) Set ENV `AUTOHEAL_CONTAINER_LABEL` to existing label name that has the value `true`.

d) set ENV CONTAINER_LIST to list of containers you want to start automatically



Note: You must apply `HEALTHCHECK` to your docker images first. See https://docs.docker.com/engine/reference/builder/#/healthcheck for details.

## ENV Defaults
```
AUTOHEAL_CONTAINER_LABEL=autoheal
AUTOHEAL_INTERVAL=300

```

## Testing
```bash
docker build -t autoheal .

docker run -d \
    -e AUTOHEAL_CONTAINER_LABEL=all \
    -v /var/run/docker.sock:/tmp/docker.sock \
    autoheal                                                                        

docker run -d \
    -e AUTOHEAL_CONTAINER_LABEL=all \
    -v /var/run/docker.sock:/tmp/docker.sock \
    -v CONTAINER_LIST="container1 container2 container3" \
    autoheal


```

