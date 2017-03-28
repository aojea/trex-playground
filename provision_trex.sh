#!/bin/sh

# Install dependencies
yum -y groupinstall "Development Tools"
yum -y install kernel-devel screen

# Install trex
cd /opt
mkdir trex
curl -L http://trex-tgn.cisco.com/trex/release/latest | tar xvzf - -C trex --strip-components 1
cd trex
# Setup ports for 2 bridges topology
./dpdk_setup_ports.py -c eth1 eth4 eth2 eth3 --ips 10.99.97.4 10.99.97.5 10.99.98.4 10.99.98.5 --def-gws 10.99.97.5 10.99.97.4 10.99.98.5 10.99.98.4  -o /etc/trex_cfg.yaml
# Smoke test stateful
./t-rex-64 -f cap2/dns.yaml -d 10 -l 1000
# Run stateless and keep it running
screen -dmS trex /opt/trex/t-rex-64 -i
