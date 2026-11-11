ui_print "- Phone Monitor Web for Infinix X6886"
ui_print "- Setting up module environment..."

pkill -f "httpd.*-p 8088" 2>/dev/null
rm -rf /data/local/tmp/sysmon /data/adb/service.d/sysmon.sh /data/local/tmp/phone_monitor 2>/dev/null
mkdir -p /data/local/tmp/phone_monitor
set_perm /data/local/tmp/phone_monitor 0 0 0755

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/service.sh 0 0 0755
set_perm $MODPATH/action.sh 0 0 0755
set_perm $MODPATH/uninstall.sh 0 0 0755
set_perm $MODPATH/www/cgi-bin/stats 0 0 0755

ui_print "- Installation complete!"
ui_print "- Reboot phone, then open: http://<phone-ip>:8088"
ui_print "- Tip: Tap 'Action' in Magisk/KernelSU to view your phone IP"
