What's the difference between a cart and a pallet?

There's a few differences, but they are subtle.  In general, most users will not need to create pallets, but will almost certainly want to create carts.  Pallets are more feature-full, but require more work to assemble.

## Carts

Carts were originally designed as a way of allowing administrators to make changes/additions to XML as well as adding packages to be installed on backend nodes.  Carts are intended to be site-specific ways to extend Stacki.

Carts can make packages available to backend nodes either during or after installation.  Carts can also contain SUX XML to enable specific configuration of nodes during installation (with anything SUX can do -- edit files, install packages, enable/disable services, run arbitrary code on the backend nodes).

That's about it.

## Pallets

Pallets are always shipped and consumed as ISO's.  Pallets have a superset of the features of carts; they can contain configuration and packages for backends, but also for frontends.  Pallets are also versioned whereas carts are not.

### Native vs Foreign

Pallets come in two flavors, native and foreign.  

Native pallets are pallets which contain Stack configuration code and were built in Stacki.  Native pallets are usually created by the Stacki team, but all of the tools we use to do so are in Stacki itself, and available to use as a Stacki administrator.  A native pallet can contain code to run on any node managed by Stacki, including the Frontend.  This allows you to extend Stacki in ways that we did not originally plan.

Foreign pallets are simply Linux distribution ISOs which Stacki has been written to understand.  The CentOS Everything DVD ISO, for example.  Code exists in Stacki that lets us parse their ISO to know where their packages are kept.  And yes, when a new OS version comes out, Stacki needs to be updated to understand any changes that have been made to the ISO disk-image layout.  Foreign pallets carry packages, but as they weren't built with Stacki in mind, they don't contain configuration information.  `stack create mirror` creates foreign pallets which contain RPM repository mirrors. 

----

Pallets are more powerful, but Native pallets at least require the extra step of compiling them before they can be used.  The output of this compilation is an ISO, which is then redistributable to another Stacki cluster.  If you're familiar with programming, this might help.

```
source code => compilation process => binary executable
pallet repo => compilation process => ISO output (aka a pallet)
```

To facilitate this, pallets have a make/build infrastructure.  You can lean on this infrastructure to compile code from source to RPM, for example.  Of course, you can still ship pre-made RPM's, but this is an example of the flexibility pallets offer that carts do not.

`stack create new pallet` will create a skeleton of a new pallet repository for you.  Native pallets which contain configuration code and packages for the Frontend can produce installation scripts with `stack run pallet`.

#### A specific example

We wanted to add functionality for configuring NetApp disk arrays within Stacki.  This included adding some packages on the Frontend -- a web service provided by NetApp that knows how to talk to these arrays, as well as some miscellaneous diagnostic packages that can talk to the array, a set of new `stack` commands for interacting with them.  In addition to the packages, it also includes SUX for configuring the Frontend to start and configure this web service along with adding a few database tables in the Stacki database to store information about the arrays.

This functionality could not have been implemented as a cart.  And further, because it's a pallet, I can ship the ISO around and other people can use it.
