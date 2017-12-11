## Getting Started

You need 1 frontend and at least one backend.

If you don't need explanations go to the [Quickstart](Quickstart).

If you have already installed a CentOS/RHEL/some variant and don't want to rebuild that server, go to [Frontend Installation on Preinstalled System](Frontend-Installation-On-Preinstalled-Systemd).

If you don't have an installed frontend, start with the full stackios iso and use:

 [Frontend Installation From ISO](Frontend-Installation-From-Iso).

Then for backends go to either:

[Backend Install Via Discovery](Backend-Installation-Via-Discovery) if you have control of your network and can run promiscuous DHCP.

or:

[Backend Install Via Spreadsheet](Backend-Installation-Via-Spreadsheet) if you have neurotic and/or obstreperous security or network teams who require you to map hostname/ip/mac address to limit the DHCP queries to a subnet.

### If you give a mouse a cluster.....

Once you've done all that and have a default frontend and a default backend up, you'll want to start [Customization](Customization). The general work flow is:

* Create a Cart
* Add packages and kickstart config
* Reinstall backend(s)
* Check/test.
* Fix or do more configuration.
* Rinse, repeat. Stop when happy.
