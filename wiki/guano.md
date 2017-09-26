This page serves as a collection for ideas that may (and in some cases should?!) never, ever be implemented in Stacki, or as an add-on to Stacki, but are interesting enough that they should be written down and kept somewhere.  Certainly, nothing written here should be read as a commitment, or even a plan.


## Idea: Replace the frontend's install wizard with a web-app

__Motivation:__ Removing WxPython would have a large impact on the build size and build time of the Stacki pallet.  It would also decrease the number of dependencies in the installer.  Finally, the wizard's code needs an overhaul.

__Detail:__ Rather than embedding a full web browser (or a doing it half-way via something like Electron), the installer would start a server-side JS server and annouce via console connectivity information.  We could even do the frontend in Covalent.

__Con__: This webapp would probably be written in JS -- this reduces code reuse

__Contra-con__: There really isn't a ton of code needed to be reused here.


## Idea: Replace tfptd with the fbtftp library

__Motivation:__ We have had users in the past bottlenecked by access to the TFTP server.

__Detail:__ fbtftp was built to be scalable, and is actually a python library allowing for potentially a CGI-like response to tftp requests.

__Con__: 

__Contra-con__: 


## Idea: Online interactive doc search

__Motivation:__ The number of stack commands is growing over time, and users discovering stack commands is now a common issue.

__Detail:__ A webapp could be created (and hosted... somewhere...?) that performed live full text search on all stacki commands and docstrings, updating as the field is populated.  For example searching 'dns' would return `stack add network`, `stack set host address`, `stack set network dns` and `sync dns` because the first to have a 'dns' parameter, and the second two have 'dns' in the command name.  Could there be some console/curses/etc trickery that allows a CLI version of this?

__Con__: Where to host?  Is live documentation useful?

__Contra-con__: 


## Idea: stack report system

__Motivation:__ Most stacki troubleshooting starts with the same half-dozen questions '`stack list pallet`, `stack list host boot`, etc'.  In some cases these are pasted in forums without any attempt at maintaining formatting, or worse are screenshots.

__Detail:__ We could create a single report command that performed a series of these commands (along with some others, like the output of `df`, etc), already formatted in some way.  This would not invalidate the need for further questions, and collecting the whole database is infeasible anyway.

__Con__: 

__Contra-con__: 


## Idea: Add callbacks to the message queue

__Motivation:__ Currently doing things like monitoring the state of the installing nodes requires polling, either via CLI or REST API.

__Detail:__ We could add an optional callback URL to the message queue.  Something along of the lines of providing a REST endpoint (and optional data?) that the frontend would POST to once it received the message.

__Con__: 

__Contra-con__: 


## Idea: Stacki FedUp as a Service (FUaaS)

__Motivation:__ For some, setting up a Stacki frontend for the first time is a large hurdle.  We could have instructions/extra functionality for setting up a master Stacki Frontend.  Internal to Teradata, this would be very useful.

__Detail:__ Stacki FedUp, to an extent allows for this.  However, PXE-booting the actual frontend may not be plausible.  This tool could allow for making that accessible over a LAN and capable of creating an attrfile and palletfile, as well as ensuring the pallets are accessible.  The node-to-be-provisioned would need to boot off of some media (to work around the DHCP issues) and then be pointed to (or know how to contact via another service/protocol such as Bonjour/mDNS?) the FedUp server.

__Con__: I don't know anything about Bonjour, but there are Apache licensed versions.

__Contra-con__: 


## Idea: 

__Motivation:__ 

__Detail:__ 

__Con__: 

__Contra-con__: 
