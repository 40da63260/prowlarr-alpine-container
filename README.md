# prowlarr-alpine-container

[Prowlarr](https://github.com/Prowlarr/Prowlarr) in an Alpine OCI Container

# What it is:

This as bare an image as I want to make for a container to be run as a non-root user. Only tested in podman.

# How to run:

`podman run --rm -it --name=prowlarr --tz=local -p 9696:9696 -v /some/downloads:/downloads -v /some/config/:/config ghcr.io/40da63260/prowlarr-alpine-container`

# Pods

With *arr software, ideally, you can run it all in a pod - and only have outgoing traffic un-firewalled. This also allows you to have DNS between containers, such that all the services can talk to one another without exiting the pod.
