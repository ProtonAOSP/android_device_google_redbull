#!/vendor/bin/sh

#
# modify config/usb_gadget/ permission
#
if [ -d /config/usb_gadget ]; then
    chown -hR system.system /config/usb_gadget/
fi
