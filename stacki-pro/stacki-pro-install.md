# Stacki Pro - Installation

## Installing the Stacki Pro Pallet

1. Download the Stacki-pro pallet.

1. Install the stacki-pro pallet on the frontend.
   ```
   # stack add pallet stacki-pro-3.2.1-7.x.x86_64.disk1.iso
   # stack enable pallet stacki-pro
   # stack run pallet stacki-pro > /tmp/stacki-pro.sh
   # sh -x /tmp/stacki-pro.sh 2>&1 | tee /tmp/stacki-pro.log
   ```

1. Reboot the frontend.

