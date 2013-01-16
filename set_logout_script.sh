#!/bin/bash

# Configure LogoutHook on OS X.
# Bernard Bolduc - 28.08.2011

echo "[+] Repairing permissions."
#chown root:wheel /Users/bolducb/etc/logout/script.sh
chmod 750 /Users/bolducb/etc/logout/script.sh

echo "[+] Inserting LogoutHook."
cd /Library/Preferences/
sudo defaults write com.apple.loginwindow LogoutHook /Users/bolducb/etc/logout/script.sh

echo "[+] Execution complete."
