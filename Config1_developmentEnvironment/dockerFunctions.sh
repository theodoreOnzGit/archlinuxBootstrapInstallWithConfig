#!/bin/bash

function copyDockerScript() {
	rm -rf ~/.dockerFunctions.sh
	cp dockerFunctions.sh ~/.dockerFunctions.sh
}

echo "copyDockerScript --> copies this script"
echo "to the home directory as .dockerFunctions.sh"
echo "warning: will replace existing .dockerFunctions.sh"
echo " "

listAllDockerContainers() {
	sudo docker ps -a
}

echo "listAllDockerContainers --> does what it says"

deleteAllDockerContainers () {
	sudo docker rm -f $(sudo docker ps -a -q)
}

echo "deleteAllDockerContainers --> also does what it says"

function dockerPrune() {
	sudo docker system prune
}

dockerRunUbuntu() {
	dockerRunContainer ubuntu
}

echo "dockerRunUbuntu --> runs the container named ubuntu"

dockerRunContainer () {
	sudo docker run -it \
		-e DISPLAY=$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--net=host \
		$1

}

dockerCommitUbuntu () {
	dockerCommit $1 ubuntu
}

echo "dockerCommitUbuntu [container-id] --> commits the container to"
echo "ubuntu"
echo " "

dockerCommit () {
	sudo docker commit $1 $2
}

