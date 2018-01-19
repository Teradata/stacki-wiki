## Installing preferred OS from webserver

If you have an ISO pallet hosted on another Stacki frontend within your infrastructure it's possible to pull that OS ISO from the web
server, and any other pallets for that matter. (This is nice if you have a Stacki server in a VM and it's available.)


I this case, boot with just the [stacki iso]() not the stackios iso.

When you get to the Pallets To Install section you should see:

picture4

Since we're just using the stacki pallet to boot we need to get some more pallets.

Choose Pallets:

Every pallet on the pallet host will show up in the list, whether the pallet on the pallet server is enabled or not. This gives the advantage of having a minimal pallet server install but able to serve all the pallets on the planet.
