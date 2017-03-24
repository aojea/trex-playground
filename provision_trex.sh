#!/bin/sh

cd /opt
mkdir trex
curl -L http://trex-tgn.cisco.com/trex/release/latest | tar xvzf - -C trex --strip-components 1
cd trex
./dpdk_setup_ports.py -c eth1 eth4 eth2 eth3 --ips 10.99.97.4 10.99.97.5 10.99.98.2 10.99.98.3 --def-gws 10.99.97.5 10.99.97.4 10.99.98.3 10.99.99.2  -o /etc/trex_cfg.yaml
./t-rex-64 -f cap2/dns.yaml -d 10 -l 1000
