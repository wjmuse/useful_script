#!/bin/bash

## Stop Services
service iptables               stop
service httpd                  stop
service dnsmasq                stop

## clean up YUM cache
yum clean all

## Clean-Up AMI
## Reference: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/building-shared-amis.html
passwd -l root
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
shred -u ~/.*history

## secure AMI
## Reference: https://aws.amazon.com/articles/0155828273219400
find /root/.*history /home/*/.*history -print -exec cat {} \;
find /root/.*history /home/*/.*history -exec rm -f {} \;
find / -name "authorized_keys" -print -exec cat {} \;
find / -name "authorized_keys" -exec rm -f {} \;
find /root/ /home/*/ -name .cvspass -print -exec cat {} \;
find /root/ /home/*/ -name .cvspass -exec rm -f {} \;
find /root/.subversion/auth/svn.simple/ /home/*/.subversion/auth/svn.simple/ -print -exec cat {} \;
find /root/.subversion/auth/svn.simple/ /home/*/.subversion/auth/svn.simple/ -exec rm -rf {} \;

## clean up history
history -c

## Display what to do next
printf "\n^[[33;1m *** Use following command to create AMI ***\n\n\taws ec2 create-image --instance-id \${INSTANCE_ID} --name \"AMI Description\"^[[0m\n\n    "
 




