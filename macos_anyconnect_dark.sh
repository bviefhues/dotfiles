# Patch Cisco AnyConnect client menu bar icons to monochrome

wget https://github.com/rarylson/cisco-anyconnect-macos-toolbar/raw/master/Resources-Dark.zip

sudo unzip -d '/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app/Contents/Resources/' Resources-Dark.zip

rm Resources-Dark.zip

