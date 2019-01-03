## Background

In this document, we will see two ways to install docker in a Ubuntu machine, and then add sudo access for the docker-engine, so that you will be able to run ```docker``` commands without ```sudo```.

<br><br>
## Docker Installation in Ubuntu Machines - the hard way



#### Step 1
ssh to the machine

#### Step 2
```
sudo apt-get -y update

sudo apt-get -y install apt-transport-https ca-certificates curlcurl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

sudo apt-get -y update

sudo apt-get -y install docker-ce

sudo docker run hello-world
```

#### Step 3
Add sudo access 

```
sudo groupadd docker
sudo usermod -aG docker $USER
exit
# log back again to the machine
```

#### Step 4
Check docker installation

```
docker info
docker version
```

<br><br>

## Docker Installation in Ubuntu Machines - the easy way

#### Step 1
ssh to the machine

#### Step 2
```
curl -sSL https://get.docker.com/ | sh
```

#### Step 3
Add sudo access 

```
sudo groupadd docker
sudo usermod -aG docker $USER
exit
# log back again to the machine
``` 

#### Step 4
Check docker installation

```
docker info
docker version
```

