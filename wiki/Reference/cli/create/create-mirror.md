## create mirror

### Usage

`stack create mirror [arch=string] [name=string] [newest=boolean] [quiet=boolean] [repoconfig=string] [repoid=string] [url=string] [urlonly=boolean] [version=string]`

### Description

	
	Create a pallet ISO image from the packages found in the
	repository located at 'URL'.

	Mirroring RHEL repositories works with a subscribed Red Hat frontend.
	Direct access via a url, will not work.

	All other public repositories can use a repoid or url.

	If using a url, "newest" and "urlonly" have no effect. The entire
	repo will be downloaded.

	

### Parameters
* `{arch=string}`
* `{name=string}`
* `{newest=boolean}`
* `{quiet=boolean}`
* `{repoconfig=string}`
* `{repoid=string}`
* `{url=string}`
* `{urlonly=boolean}`
* `{version=string}`

   The version number of the created pallet. (default = the version of 
	Rocks running on this machine).

### Examples

* `stack create mirror url=http://mirrors.kernel.org/centos/6.5/updates/x86_64/Packages name=updates version=6.5`

   Creates a mirror for CentOS 6.5 based on the packages from mirrors.kernel.org.
	The pallet ISO will be named 'updates-6.5-0.x86_64.disk1.iso'.

* `stack create mirror repoid=rhel-6-server-rpms newest=yes version=6.5`

   Creates a mirror for RHEL 6.5 based on the latest packages from cdn.redhat.com.
	The pallet ISO will be named rhel-6-server-rpms-6.5-0.x86_64.disk1.iso.

* `stack create mirror url=/tmp/ansible_deps name=ansible version=4.0`

   Creates a pallet based on packages already collected in /tmp/ansible_deps
	to install Ansible with dependencies.
	The pallet ISO will be named ansible-4.0-7.x.x86_64.disk1.iso



