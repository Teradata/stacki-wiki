There may come a point where it makes sense to create your own pallets. There are three types: RPM only, configuration only, and configuration + RPMS.

Pallets allow you to install and configure applications you have created or downloaded. It's a simple way to keep multiple versions or to do patching/upgrading.

Additionally, if your site-specific requirements are complex and can't be easily captured using the "extend/replace" methods found in the [Extend Backend Nodes](https://github.com/StackIQ/stacki/wiki/Extend-Backend-Nodes) documentation, a site-specific pallet is one of the ways to capture all the required configuration and site-specific RPMS.

RPM-only pallets are the simplest to create. We'll show you how to do that. However, there are a few pieces missing from the current stacki-1.0-I release we'll have to add.

##### Fix the build environment part I



##### RPM-only Pallet



