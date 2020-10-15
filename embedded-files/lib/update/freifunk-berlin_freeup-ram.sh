
ffberlin_freeup_ram() {
  local SERVICES
  local service

  SERVICES="cron pingcheck uhttpd"

  # stop services if existing and running
  for service in $SERVICES; do
    [ -x /etc/init.d/${service} ] && { /etc/init.d/${service} running && /etc/init.d/${service} stop; }
  done

  # remove LuCI-caches
  rm >/dev/null -f /tmp/luci-indexcache*
  rm >/dev/null -rf /tmp/luci-modulecache

}

ffberlin_freeup_ram

