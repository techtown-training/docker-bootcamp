## Lab Setup for docker-bootcamp course

### Create instances

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