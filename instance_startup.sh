#!/bin/bash -xe
# This startup script was used to validate general approach prior to
# updating cloudformation template - this script will run successfully
# to pull from s3 in AWS, extract content, and then remove the orignial
# tarball (once extracted).
# This startup script then starts up docker containers for Confluence
# and Jira.
#!/bin/bash -xe
yum update -y #update system
aws s3 cp s3://showroomdocker/down/s3cp-down.tar.gz /home/ec2-user/ #pull tarball from s3, put local
su ec2-user -c '(cd /home/ec2-user/ && tar -xvf /home/ec2-user/s3cp-down.tar.gz)' # extract local tarball
sudo -H -u ec2-user bash -c '(cd /home/ec2-user/atlassianDocker/atlassianDocker/ && /usr/local/bin/docker-compose up -d)' #launch docker containers
rm -rf /home/ec2-user/s3cp-down.tar.gz # cleanup/remove old tarball
