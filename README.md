# Task 10: How to setup an AWS Site-to-Site (S2S) VPN Connection
## <center>Architecture Diagram</center>
![no_image](https://labresources.whizlabs.com/73beff77d4bb448c2493e960e609ea6d/transit_gateway-2.png)

## Test the connectivity between two VPCs:
### In this task, we are going to test the connectivity between the EC2 instances in both VPCs. This step confirms that the VPCs have been successfully peered using the Transit Gateway, and the EC2 instances can communicate with each other.
### 1. You have copied the IPv4 Public IP of the EC2 instance created in the First VPC.
### 2. Please follow the steps in [SSH into EC2 Instance](https://www.whizlabs.com/labs/support-document/ssh-into-ec-instance) to SSH into First_VPCs_EC2
### 3. Once you have successfully SSH in to EC2, run the following commands :
- Switch to root user :

        sudo su

- Update server repository :

        yum update -y

### 4. Now we need to copy the .pem key of the EC2 instance created.

- Create a file :

        nano ec2_ssh_key.pem

![no_image](https://labresources.whizlabs.com/73beff77d4bb448c2493e960e609ea6d/image74.png)

- Open the .pem key of EC2 ec2_ssh_key in your local editor and paste it in the terminal file.

![no_image](https://labresources.whizlabs.com/73beff77d4bb448c2493e960e609ea6d/image84.png)

### 5. Change the .pem key permission

        chmod 400 ec2_ssh_key.pem

### 6. SSH into the Private EC2 ec2_ssh_key

        ssh ec2-user@<IPv4 private Ip> -i ec2_ssh_key.pem

-  Copy the Private IP of Second_VPCs_EC2
-  Example : ssh ec2-user@20.0.0.11 -i ec2_ssh_key.pem

### 7. If the connection prompts a message to confirm connect enter yes
![no_image](https://labresources.whizlabs.com/73beff77d4bb448c2493e960e609ea6d/image88.png)

### 8. As you can see the IP address is changed to private ec2 private IP 30.0.1.154
![no_image](https://digitalcloud.training/wp-content/uploads/2020/10/Authenticate-with-SSH-agent.jpg)
