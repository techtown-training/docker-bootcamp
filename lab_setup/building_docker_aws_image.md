## Building the Docker image for the first time
Below describes the steps to create AWS image for docker-bootcamp course.

### Launch Ubuntu instance
- OS:- Ubuntu Server 16.04
- Machine type:- General Purpose t2.micro
- Auto-assign Public IP:- enable
- Storage: 8G
- Security Group: all-in-all

### Login to the ubuntu machine


### Install Docker
```
sudo apt-get -y update
curl -sSL https://get.docker.com/ | sh
sudo groupadd docker
sudo usermod -aG docker $USER
exit
# log back again to the machine
# run below commands to check installation
docker info
docker version
```

### Create Image from the above instance

Create Image using AWS UI

## Image details
- Image name: docker-bootcamp
- Id: ami-069ac4c035e8d8d74
<br> <b>This image has been created and stored in ASPE AWS account </b>


## Instance connection
Three things are required to connect to AWS instance

- <b>username:</b> ubuntu (all small case)
- <b>Password:</b> There is no password, ASPE will provide the Default.ppk or Default.pem file. To mention here, if you are using unix/mac machines to connect, you need pem file, set the permission to `400`
- <b>IP:</b> ASPE will provide the IP address, for this course we need 1 instance per student

For the docker course, the instance will have Docker installed in it. There's nothing else required.
