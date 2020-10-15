#echo >&2 "This is the Freifunk Berlin-script"

#MEMLIMIT=33554432   # 32MB
SERVICES="cron pingcheck uhttpd"

#MEMFREE=$(cat /proc/meminfo |grep MemTotal|awk '{print $2}')

#MEM=$(cat /proc/meminfo | head -n 3)
#echo >&2 "mem before: ${MEM}"

#ifdown ffuplink

#echo stopping non-essential services
for service in $SERVICES; do
#  echo >&2 -n "${service} "
  [ -x /etc/init.d/${service} ] && { /etc/init.d/${service} running && /etc/init.d/${service} stop; }
done
#echo >&2 ""

#echo >&2 flushing files from /tmp
rm >/dev/null -f /tmp/luci-indexcache*
rm >/dev/null -rf /tmp/luci-modulecache

#MEM=$(cat /proc/meminfo | head -n 3)
#echo >&2 "mem after: ${MEM}"

#echo >&2 "ps: " $(ps w)

#echo >&2 end of Freifunk Berlin-script
#exit 10

