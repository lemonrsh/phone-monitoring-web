#!/system/bin/sh
MODDIR=${0%/*}
PORT=8088

until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 3; done
sleep 5

BB=""
for b in /data/adb/magisk/busybox /data/adb/ksu/bin/busybox /data/adb/ap/bin/busybox "$(command -v busybox)"; do
  if [ -x "$b" ] && "$b" --list 2>/dev/null | grep -qx httpd; then
    BB=$b
    break
  fi
done
[ -n "$BB" ] || exit 1

mkdir -p /data/local/tmp/phone_monitor
chmod 0755 /data/local/tmp/phone_monitor
chmod 0755 "$MODDIR/www/cgi-bin/stats" 2>/dev/null

H=/data/local/tmp/phone_monitor/temp30.log
(while true; do
  ts=$(date +%s)
  vals=""
  for z in /sys/class/thermal/thermal_zone*; do
    [ -r "$z/temp" ] || continue
    read -r v < "$z/temp"
    case "$v" in ''|*[!0-9-]*) continue;; esac
    vals="$vals $v"
  done
  echo "$ts$vals" >> "$H"
  n=$(wc -l < "$H")
  [ "$n" -gt 185 ] && tail -n 180 "$H" > "$H.tmp" && mv "$H.tmp" "$H"
  sleep 10
done) >/dev/null 2>&1 &

pkill -f "httpd.*-p $PORT" 2>/dev/null
sleep 1
"$BB" httpd -p $PORT -h "$MODDIR/www"
