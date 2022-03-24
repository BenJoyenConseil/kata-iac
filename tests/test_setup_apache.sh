#!/usr/bin/env bash

export DOCKER_BUILDKIT=1

container="apache2"
image="apache2:duck-conf"
setup_vm_path="02_ec2/script/setup_vm.sh"
apache_config_gitpath="03_apache/dev/httpd.conf"

docker build -f tests/centos/Dockerfile \
             --build-arg "apache_conf=${apache_config_gitpath}" \
             --build-arg "script_path=${setup_vm_path}" \
             -t ${image} \
             .

docker container rm -f ${container}
docker run --name ${container} \
           --privileged \
           -p 80:80 \
           ${image}