## remove firmware make

### Usage

`stack remove firmware make {make ...}`

### Description


	Removes firmware makes from the stacki database.

	

### Arguments

* `[make]`

   One or more make names to remove. This will also remove any associated models and firmware associated with those models.


### Examples

* `stack remove firmware make mellanox dell`

   Removes two makes with the names 'mellanox' and 'dell'. This also removes any associated models and firmware associated with the models removed.



