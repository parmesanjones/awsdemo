#!/bin/bash -xe

# this file is purely a historical reference as i whittled through some
# things to find out what worked as a startup script vs. what needed
# modifications in order to perform similar function but within AWS
# user data field to launch things at startup for showroom


yum update -y;
aws s3 cp s3://showroomdocker/down/s3cp-down.tar.gz /home/ec2-user/;
tar -xvf /home/ec2-user/s3cp-down.tar.gz;
sudo -H -u ec2-user bash -c '(cd /home/ec2-user/atlassianDocker/atlassianDocker/ && /usr/local/bin/docker-compose up -d)';




#!/bin/bash -xe
yum update -y
aws s3 cp s3://showroomdocker/down/s3cp-down.tar.gz /home/ec2-user/
su ec2-user -c '(cd /home/ec2-user/ && tar -xvf /home/ec2-user/s3cp-down.tar.gz)'
sudo -H -u ec2-user bash -c '(cd /home/ec2-user/atlassianDocker/atlassianDocker/ && /usr/local/bin/docker-compose up -d)'
rm -rf /home/ec2-user/s3cp-down.tar.gz




#!/bin/bash -xe
yum update -y
(cd /home/ec2-user && aws s3 cp s3://showroomdocker/down/s3cp-down.tar.gz - | tar -xz)
sudo -H -u ec2-user bash -c '(cd /home/ec2-user/atlassianDocker/atlassianDocker/ && /usr/local/bin/docker-compose up -d)'
# this is the streamlined version of the shell script above
# both this and above will work as shell scripts or startup scripts
# however, this is less taxing, faster, shorter, and requires 
# less resources - it streams the tarball and therefor doesn't need
# to remove it afterwards, as it's never saved in the first place
