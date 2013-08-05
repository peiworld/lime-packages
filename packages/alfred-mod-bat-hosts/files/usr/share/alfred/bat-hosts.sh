#!/bin/sh

tmp_bat_hosts=/tmp/bat-hosts
type_id=64

write_bat_hosts () {
  echo -e "$(alfred -r $type_id | sed -e 's/{ "[^"]\+", "\(.*\)" },/\1/' )" > /tmp/bat-hosts
}

propagate_own_macs () {
  hostname="$(cat /proc/sys/kernel/hostname)"
  echo $(batctl o |head -n1|sed "s|.*MainIF/MAC: \([^/]\+\)/\([^ ]\+\) .*|\2 ${hostname}_\1|") | alfred -s $type_id
}

propagate_own_macs
write_bat_hosts
