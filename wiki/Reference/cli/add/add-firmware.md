## add firmware

### Usage

`stack add firmware {version} [hash=string] [hash_alg=string] [hosts=string] [imp=string] [make=string] [model=string] [source=string]`

### Description


	Adds a firmware image to stacki.



### Arguments

* `[version]`

   The firmware version being added. This must be unique for make + model.


### Parameters
* `{hash=string}`
* `{hash_alg=string}`
* `{hosts=string}`
* `{imp=string}`
* `{make=string}`
* `{model=string}`
* `{source=string}`

   The URL or local file path pointing to where to retrieve the firmware image.

### Examples

* `stack add firmware 3.6.5002 source=/export/some/path/img-3.6.5002.img make=Mellanox model=m7800 imp=mellanox_m7800`

   Fetches the firmware file from the source (a local file on the front end in /export/some/path), associates it with the
	Mellanox make and 7800 model, and sets the version to 3.6.5002, and adds it to be tracked in the stacki database.

* `stack add firmware 3.6.5002 source=http://www.your-sweet-site.com/firmware/mellanox/img-3.6.5002.img make=Mellanox model=m7800 imp=mellanox_m7800`

   This performs the same steps as the previous example except the image is fetched via HTTP.

* `stack add firmware 3.6.5002 source=http://www.your-sweet-site.com/firmware/mellanox/img-3.6.5002.img make=Mellanox model=m7800 hosts=switch-0-1,switch-0-2`

   This performs the same steps as the previous example except the firmware gets associated with the hosts named switch-0-1 and switch-0-2.

* `stack add firmware 3.6.5002 source=http://www.your-sweet-site.com/firmware/mellanox/img-3.6.5002.img make=Mellanox model=m7800 hosts=a:switch`

   This performs the same steps as the previous example except the firmware gets associated with all hosts that are of the appliance switch type.

* `stack add firmware 1.2.3.4 source=/export/some/path/my-file make=new_make model=new_model imp=new_imp`

   Assuming that the make, model, and implementation do no already exist, this adds a new firmware version 1.2.3.4
	associated with new_make and new_model that will use new_imp to read and write to mapped hosts.



