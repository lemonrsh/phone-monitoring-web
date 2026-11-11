ui_print "- Phone Monitor Web"
ui_print "- Removing old manual install (if any)"
pkill -f "httpd.*-p 8088" 2>/dev/null
rm -rf /data/local/tmp/sysmon /data/adb/service.d/sysmon.sh 2>/dev/null
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/service.sh 0 0 0755
set_perm $MODPATH/action.sh 0 0 0755
set_perm $MODPATH/uninstall.sh 0 0 0755
set_perm $MODPATH/www/cgi-bin/stats 0 0 0755
ui_print "- Done. Reboot, then open http://<phone-ip>:8088"
ui_print "- Tip: tap the module's Action button to see the address"
