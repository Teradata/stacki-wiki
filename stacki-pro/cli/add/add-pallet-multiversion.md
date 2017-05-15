---
layout: page
title: add pallet multiversion
permalink: /add-pallet-multiversion
sidebarloc: /stacki-pro/cli/add
---

## add pallet multiversion

### Usage

`stack add pallet multiversion [pallet ...] [clean=bool] [dir=string] [updatedb=string]`

### Description

Add stacki-pro or stacki pallets of a lower version to
	enable support for OS distributions that are different than
	the current higher version. 
	
	This means you can install 6.x machines from a 7.x stacki frontend.

### Arguments

* `{pallet}`

   A list of pallet ISO images to add to the local machine. If no list is
	supplied, then if a pallet is mounted on /mnt/cdrom, it will be copied
	to the local machine. The pallets for this command should be "stacki"
	or "stacki-pro." All others should be added with the "stack add pallet"
	command.


### Parameters
* `{clean=bool}`
* `{dir=string}`
* `{updatedb=string}`

   Add the pallet info to the cluster database.
	The default is: true.

### Examples

* `stack add pallet multiversion clean=1 stacki-3.2-7.x.x86_64.disk1.iso`

   Adds the Kernel pallet to local pallet directory.  Before the pallet is
	added the old Kernel pallet packages are removed from the pallet
	directory.

* `stack add pallet multiversion stacki-3.2-7.x.x86_64.disk1.iso`

   Added the Kernel, PVFS, and Ganglia pallets to the local pallet
	directory.


### Related
[create pallet](create-pallet)

[disable pallet](disable-pallet)

[enable pallet](enable-pallet)

[list pallet](list-pallet)

[remove pallet](remove-pallet)


