echo "This is the Freifunk Berlin-script"

MEMLIMIT=33554432   # 32MB
SERVICES="cron pingcheck uhttpd rpcd odhcpd"        

MEMFREE=$(cat /proc/meminfo |grep MemTotal|awk '{print $2}')

ifdown ffuplink

echo stopping non-essential services
for service in $SERVICES; do
  echo -n "${service} "
  [ -x /etc/init.d/${service} ] && /etc/init.d/${service} running && { /etc/init.d/${service} stop; echo -n " ..stopped.. "; }
done
echo ""

echo flushing files from /tmp
rm >/dev/null -f /tmp/luci-indexcache*
rm >/dev/null -rf /tmp/luci-modulecache


echo end of Freifunk Berlin-script
#exit 10

