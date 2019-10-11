## remove firmware model

### Usage

`stack remove firmware model {model ...} [make=string]`

### Description


	Removes a firmware model from the stacki database.

	

### Arguments

* `[model]`

   One or more model names to remove. Any firmware associated with the models will also be removed.


### Parameters
* `{make=string}`

   The maker of the models being removed. This must correspond to an already existing make.

### Examples

* `stack remove firmware model awesome_9001 mediocre_5200 make='boss hardware corp'`

   Removes two models with the names 'awesome_9001' and 'mediocre_5200' from the set of available firmware models under the 'boss hardware corp' make.
	This also removes any firmware associated with those models.



