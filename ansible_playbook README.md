#Created inventory.ini file for connecting with instance
#Create ansible.yml file for playbook which starts the Docker service, and runs a sample Nginx container on the EC2 instance.
ansible.yml- script includes
       specifies the target host group for this playbook
        Update APT package repository
        Install prerequisite packages
        Add Docker's official GPG key
        Add Docker APT repository
        Install Docker Engine
        Start and enable Docker service
        Add user to the Docker group
       Enable Docker to Start on Boot

# Running the Playbook
# test the connection

ansible -i inventory.ini ec2 -m ping # test the connection
ansible-playbook -i inventory.ini ansible.yml   #This command installs Docker, starts it as a service, pulls the Nginx Docker image, and runs it in a container on the EC2 instance.

http://ec2_public_ip:80  
Troubleshooting:
Verify the security group attached to the EC2 instance allows inbound traffic on port 80 for HTTP from security group