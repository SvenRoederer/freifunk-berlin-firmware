. /usr/share/libubox/jshn.sh

ffberlin_freeup_ram() {
  local SERVICES
  local service
  local TARGET

  json_load "$(ubus call system board)"
  json_select release
  json_get_var TARGET target
  # continue only on "tiny" subtargets
  [ ${TARGET} = ${TARGET%/tiny} ] && return

  ifdown ffuplink
  ifdown tunl0

  SERVICES="cron pingcheck uhttpd rpcd urngd firewall dnsmasq rssi"

  # stop services if existing and running
  for service in $SERVICES; do
    [ -x /etc/init.d/${service} ] && { /etc/init.d/${service} running && /etc/init.d/${service} stop; }
  done

  # remove LuCI-caches
  rm >/dev/null -f /tmp/luci-indexcache*
  rm >/dev/null -rf /tmp/luci-modulecache

  /etc/init.d/zram stop

  [ -x /sbin/lsmod ] || return
  # remove unused kernel modules
  PREV_MOD_COUNT=0
  while true; do
    UNUSED_MODULES=$(lsmod |grep '[[:space:]]0 $'| cut -d " " -f 1)
    # exit loop, when no unused modules or no additional modules could be made unused
    [ -z "${UNUSED_MODULES}" ] && break
    [ $(echo ${UNUSED_MODULES} | wc -w) -eq ${PREV_MOD_COUNT} ] && break
    for module in ${UNUSED_MODULES}; do
      rmmod $module
    done
    PREV_MOD_COUNT=$(echo ${UNUSED_MODULES} | wc -w)
  done
}

# taken from Gluon (http://lists.infradead.org/pipermail/openwrt-devel/2020-October/031783.html)
echo 3 > /proc/sys/vm/drop_caches

ffberlin_freeup_ram
