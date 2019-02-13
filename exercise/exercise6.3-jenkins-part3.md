# Part 3 - Set Up a Sample Continuous Integration Pipeline with Jenkins & Docker

Let's leverage our earlier effort at building a Jenkins node in Docker to build a Continuous Integration pipeline. We will be adapting our earlier jenkinsdocker image.

# Install Docker Compose in the ~/jenkinsdocker/Dockerfile

Since our example requires Docker-Compose, we will need to install Docker-Compose within our Dockerfile. There are two common ways to install Docker-Compose, the first is with a curl script (as in a previous example) and the second is through Python-pip. Since installing with a curl script in our Dockerfile requires sudo and tends to be interfered with by networking proxies, let's use the pip method.

Within in the Dockerfile we will need to make sure `python-pip` is installed before we install `docker-compose`.

## Add Docker-Workflow to Jenkins Plugins

We also will require the Jenkins Docker-Workflow plugin. We could add this every time we start Jenkins from the GUI (like we did with the "Recommended Plugins), but lets automate the process saves us that manual effort.  Within the updated Dockerfile below you will notice that the jenkins plugins ar installed as the `jenkins` user.

For this exercise we also need `libltdl7` installed our Jenkins image.

# Full Dockerfile
The full Dockerfile will look like
```
FROM jenkins/jenkins:lts

USER root
RUN apt-get update \
      && apt-get install -y sudo python-pip libltdl7 \
      && rm -rf /var/lib/apt/lists/* \
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN pip install docker-compose

USER jenkins
RUN /usr/local/bin/install-plugins.sh workflow-aggregator && \
    /usr/local/bin/install-plugins.sh docker-workflow && \
    /usr/local/bin/install-plugins.sh git
```

# Rebuild the jenkinsdocker Image

This step may take a while. Python might be built from source, etc.

```
cd ~/jenkinsdocker
docker build -t jenkinsdocker .
```


# Start a New Jenkins Container and Run as Root

We will run our newly redesigned jenkinsdocker image as a fresh container, but this time we will specify that the commands should be run as the root user. This will allow the container to call sudo docker when the docker pipeline plugins runs commands. As before, we're allowing this new container the ability to make calls to the host docker engine.

```
docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
              -v $(which docker):/usr/bin/docker -p 8080:8080 -u root \
              jenkinsdocker
```

# Create a new Jenkins Pipeline and test deployment

Once again, walk through setting up the Jenkins instance by grabbing password from the new container's log (docker container log <ID>), visiting the container's URL (FQDN:8080), setting up a new admin user account, and installing the recommended plugins. Then do the following:

1. Select the "create new jobs" link
2. Select the Pipeline type and name the job "example-pipeline"
3. Add the following in the pipeline script:

```
node {  
  stage 'Checkout'
  git url: 'https://github.com/papaludwig/jenkins-docker-example.git'  

  stage 'Build'
  docker.build('mobycounter')  

  stage 'Deploy'  
  sh './deploy.sh'
}
```

4. Save the job
5. Click "Build Now" to run the pipeline.

The git url pulls down all the components for a complete docker-compose based "system" that includes a redis service, a web service, etc. and causes all of that to be built using the host's docker engine.

The build stage can take quite some time, because it will be causing new images to be downloaded, etc. Expect a max of about 4 minutes.

If the Checkout, Build, and Deploy steps all succeed then you can view the application running on the ip of the Jenkins Server at port 80. Enter the IP in your browser window and if you see a 'click to add icons' message then your application has succeeded. Each time you click, the logo of our favorite containerization will be added where you click, and the position and count will be saved in a Redis DB. Visiting the page again will cause all of your old clicks to be replayed.
