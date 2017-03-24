#!/bin/bash

yum update
yum install -y epel-release
yum -y install crudini wget git tcpdump

#Midonet repo
cat <<EOF > /etc/yum.repos.d/midokura.repo
[midonet-openstack-integration]
name=MidoNet OpenStack Integration
baseurl=http://builds.midonet.org/openstack-mitaka/stable/el7/
enabled=1
gpgcheck=0
gpgkey=http://builds.midonet.org/midorepo.key
[midonet-misc]
name=MidoNet 3rd Party Tools and Libraries
baseurl=http://builds.midonet.org/misc/stable/el7/
enabled=1
gpgcheck=0
gpgkey=http://builds.midonet.org/midorepo.key
[midonet-mem]
name=Midonet MEM packages
baseurl=http://artifactory.bcn.midokura.com/artifactory/mem-5.6-rpm/unstable/el7/
enabled=1
gpgcheck=0
gpgkey=http://artifactory.bcn.midokura.com/artifactory/api/gpg/key/public
EOF

# NSDB node
# Zookeeper installation and configuration
yum -y install java-1.8.0-openjdk-headless
yum -y install zookeeper nmap-ncat
yum -y install zkdump
echo -e "server.1=localhost:2888:3888\nautopurge.snapRetainCount=10\nautopurge.purgeInterval=12" >> /etc/zookeeper/zoo.cfg
mkdir /var/lib/zookeeper/data
chown zookeeper:zookeeper /var/lib/zookeeper/data
echo "1" > /var/lib/zookeeper/data/myid
mkdir -p /usr/java/default/bin/
ln -s /usr/lib/jvm/jre-1.8.0-openjdk/bin/java /usr/java/default/bin/java
systemctl enable zookeeper.service
systemctl start zookeeper.service

# Install midonet
yum -y install midonet-cluster midolman 
systemctl enable midonet-cluster.service
systemctl start midonet-cluster.service
systemctl enable midolman.service
systemctl start midolman.service

# MidoNet CLI installation
yum -y install python-midonetclient
cat > /root/.midonetrc <<RE_CONF
[cli]
api_url = http://localhost:8181/midonet-api
username = admin
password = openstack
project_id = admin
RE_CONF

cp /root/.midonetrc /home/vagrant/.midonetrc

