## list firmware model

### Usage

`stack list firmware model {models ...} [expanded=bool] [make=string]`

### Description


	Lists firmware models tracked by stacki.

	

### Arguments

* `[models]`

   Zero or more models to list information for. If no models are specified, all models are listed.


### Parameters
* `{expanded=bool}`
* `{make=string}`

   The optional make of the models to list. This is required if models are specified as arguments.
	Setting this with no models specified will list all models for the given make.

### Examples

* `stack stack list firmware model`

   Lists all firmware models tracked in the stacki database.

* `stack stack list firmware model make=mellanox`

   Lists information for all firmware models under the mellanox make.

* `stack stack list firmware model m7800 m6036 make=mellanox`

   Lists information for the firmware models m7800 and m6036 under the mellanox make.

* `stack stack list firmware model expanded=true`

   Lists additional information for all firmware models tracked in the database.



