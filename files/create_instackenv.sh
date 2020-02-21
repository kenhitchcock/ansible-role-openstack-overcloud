#!/bin/bash

VHOST="ssh root@192.168.122.1 "
PROVISIONNETWORK="default"

(
for i in $(cat /tmp/overcloud-nodes); do
  addr=$($VHOST vbmc show $i | awk '/address/ {print "\""$4"\"" }')
  port=$($VHOST vbmc show $i | awk '/port/ { print "\""$4"\"" }')
  mac="`$VHOST /usr/bin/virsh domiflist $i | grep openstack | awk '{print $5}'`"
  cpu="`$VHOST /usr/bin/virsh dumpxml $i | grep vcpu | awk -F '>' '{print $2}' | awk -F '<' '{print $1}'`"
  memory="`$VHOST /usr/bin/virsh dumpxml $i | grep memory | awk -F '>' '{print $2}' | awk -F '<' '{print $1}'`"

  cat <<EOF
      {
         "mac": [
            "$mac"
         ],
         "name": "$i",
         "pm_addr": $addr,
         "pm_port": $port,
         "pm_password": "$(cat ~/.ssh/id_rsa)",
         "pm_type": "pxe_ssh",
         "cpu": "$cpu",
         "memory": "$((memory / 1024))",
         "disk": "60",
         "arch": "x86_64",
         "pm_user": "root"
      }
EOF

done
) |  jq -s '{ "ssh-user": "root",
              "ssh-key": "$(cat ~/.ssh/id_rsa)",
              "power_manager": "nova.virt.baremetal.virtual_power_driver.VirtualPowerManager",
              "host-ip": "192.168.122.1",
              "arch": "x86_64",
              "nodes": . }' > instackenv.json
