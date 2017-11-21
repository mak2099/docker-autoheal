#!/bin/bash
set -e
set -u
set -o pipefail

E_CONTAINERS=(practical_kilby friendly_jennings bubbles_1 autoheal)
R_CONTAINERS=($(curl --no-buffer -s -XGET --unix-socket /var/run/docker.sock  http://localhost/containers/json |jq -r '.[].Names'  |jq -r .[] | cut -d '/' -f2))
A_CONTAINERS=($(curl --no-buffer -s -XGET --unix-socket /var/run/docker.sock  http://localhost/containers/json?all=true |jq -r '.[].Names'  |jq -r .[] | cut -d '/' -f2))
G_STATUS=()

echo "Monitoring for stopped containers"
while true; do
  sleep 120

#echo ${E_CONTAINERS[@]}
#echo ${R_CONTAINERS[@]}
#echo ${A_CONTAINERS[@]}

for e_container in ${E_CONTAINERS[@]}; do
  if [[ $(echo ${A_CONTAINERS[@]} |grep -Ew "${e_container}" | wc -l) -eq 1 ]]; then
    #echo "container $e_container is in running list for ${A_CONTAINERS[@]}"
    # get status
      status=$(curl --no-buffer -s -XGET --unix-socket /var/run/docker.sock  http://localhost/containers/$e_container/json |jq -r '.State.Status')
      #echo "$e_container status is $status"
        if [ ! ${status} == "running" ]; then
        # attempt to start the container
      	  echo "starting container $e_container"
      	  curl -f --no-buffer -s -XPOST --unix-socket /var/run/docker.sock http://localhost/containers/${e_container}/start || echo "$(DATE) starting container ${e-container} failed"
        fi  
  fi
done


done
