## add firmware model

### Usage

`stack add firmware model {models ...} [imp=string] [make=string]`

### Description


	Adds firmware models to the stacki database.

	

### Arguments

* `[models]`

   One or more model names to add. Model names are required to be unique, and any duplicates will be ignored.


### Parameters
* `{imp=string}`
* `{make=string}`

   The make of the models being added. If this does not correspond to an already existing make, one will be added.

### Examples

* `stack add firmware model awesome_9001 mediocre_5200 make='boss hardware corp' imp=boss_hardware_corp`

   Adds two models with the names 'awesome_9001' and 'mediocre_5200' to the set of available firmware models under the 'boss hardware corp' make.
	This also sets the implementation to run for those models as the one named 'imp_boss_hardware_corp.py'.



