## Lab Setup for docker-bootcamp course

### Create instances
You can find the image in ASPE AWS account.
- Select image `ami-069ac4c035e8d8d74` OR `docker-bootcamp`
- Type of instance required `t2.micro`
- Enable `Auto-assign public IP`
- 8G storage
- Select `all-in-all` security group


### Number of Instances required
1 per student


### Test connection and instance (for ASPE)
Login to one of the instances and run command `docker info` to verify if Docker runs properly

### Test connection and instance (for clients)
Following needs to be sent to the client to test their connection

- IP address of one of the machines
- Default.pem/ppk files
- Word document with testing instruction
```
Test_Instance_and_Connection.docx
```

All required instruction for testing in mentioned in the word document.

## Instance connection
Three things are required to connect to AWS instance

- <b>username:</b> ubuntu (all small case)
- <b>Password:</b> There is no password, ASPE will provide the Default.ppk or Default.pem file. To mention here, if you are using unix/mac machines to connect, you need pem file, set the permission to `400`
- <b>IP:</b> ASPE will provide the IP address, for this course we need 1 instance per student

For the docker course, the instance will have Docker installed in it. There's nothing else required.