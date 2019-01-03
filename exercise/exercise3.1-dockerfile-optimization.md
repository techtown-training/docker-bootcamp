# Docker File Optimization

Each line in Dockerfile creates a **layer** in the Docker image. 

## Dockerfile with lots of layers

Here is the code of a sample un-optimized Dockerfile:

```
# Use ubuntu as base image
FROM ubuntu:latest

# update and install packages
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y wget

# create directories
RUN mkdir -p foo
RUN mkdir -p bar

# Set one or more individual labels
LABEL com.example.version="0.0.1-beta"
LABEL vendor1="ACME Incorporated"
LABEL vendor2=ZENITH\ Incorporated
LABEL com.example.release-date="2015-02-12"
LABEL com.example.version.is-production=""

# Entrypoint
CMD ["/bin/bash"]
```

Build the image using above Dockerfile

```
docker build -t unoptimized-image:0.1 .
```

The above image when built creates **12 layers**

> Check the layers by running 
> 
```
docker history unoptimized-image:0.1
```

## Dockerfile with fewer layers

Now let's make the dockerfile more optimized. Here is the code of optimized Dockerfile:

```
FROM ubuntu:latest

# update and install packages
RUN apt-get update && \
	apt-get install -y \
   	curl \
   	wget
        
# create directories
RUN mkdir -p foo && mkdir -p bar

# Set one or more individual labels
LABEL vendor=ACME\ Incorporated \
      com.example.is-beta= \
      com.example.is-production="" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2015-02-12"

# Entrypoint
CMD ["/bin/bash"]
```
Build the image using above Dockerfile

```
docker build -t optimized-image:0.1 .
```

The above image when built creates **5 layers**

> Check the layers by running 
> 
```
docker history optimized-image:0.1
```