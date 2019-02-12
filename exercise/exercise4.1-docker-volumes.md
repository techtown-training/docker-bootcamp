# Docker Volume

In this exercise, we are going to look at how to manage data within your Docker containers.

Containers are **Ephemeral** and once a container is removed, it is gone (**including data**). What about scenarios where you want the applications running inside the container to write to some files/data and then ensure that the data is still present?

There are 2 ways in which you can manage data in Docker:

* Data volumes
* Data volume containers


Few points to keep in mind about **Data Volumes**

* A data volume is a specially designed directory in the container.
* It is initialized when the container is created. By default, it is not deleted when the container is stopped. It is not even garbage collected when there is no container referencing the volume.
* The data volumes are independently updated. Data volumes can be shared across containers too. They could be mounted in read-only mode too.

## Mount volumes by absolute path
You can mount volumes from host to containers using absolute path as shown below

```
# In the host machine
mkdir -p ~/foo/bar
touch foo/bar/file.1
docker run -it -v ~/foo/bar:/data --name vol1 ubuntu:latest

# The above command takes you to the container
ls /data 			--> you should see /foo/bar/file.1
# Create another file in the container
touch /data/file.2

# Come out of container without stopping it
cntrl P Q

# Check the host directory for the two files
ls ~/foo/bar/		--> you should see file.1 and file.2
```


## Mount a directory as Docker-Volume

```
# This will list all volumes in the docker-engine
docker volume list

# Create a volume
docker volume create myvolume

# Check the physical location of volume
docker volume inspect -f {{.Mountpoint}} myvolume

# Start a container mounting docker volume
docker run -it -v myvolume:/data --name vol2 ubuntu:latest		--> Note that we did not give absolute path of the directory, rather used docker-volume name

# You are in the container now.
cd /data
touch file.1
echo "Hello there" >> file.1

# Come out of container without stopping it
cntrl P Q

# Check the docker volume directory for the file "file.1"
# Note:- you may have to be superuser in order to run the above command because docker-volume are located in /var/lib
sudo su -
ls `docker volume inspect -f {{.Mountpoint}} myvolume`
```
