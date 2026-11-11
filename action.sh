#!/system/bin/sh
echo "Phone Monitor - open on any device on your network:"
ip -4 -o addr show | sed -n 's/.*inet \([0-9.]*\).*/  http:\/\/\1:8088/p' | grep -v '127.0.0.1'
if pgrep -f "httpd.*-p 8088" >/dev/null 2>&1; then echo "Status: running"; else echo "Status: NOT running (reboot or check busybox httpd)"; fi
