Stacki enables you to create a "distribution" which holds the pallets a particular machine will use for its software configuration. The "default" distribution consists of the "stacki" pallet and an OS pallet (Could be CentOS or RHEL or any other RHEL variant). These two pallets are the minimal requirement for installing a backend machine. Backend machines are assigned the "default" distribution by design. 

Machines can be assigned to a different distribution containing the software required for a set of backend machines. Different machines can be assigned different distributions. This gives you a great deal of latitude in deciding how to structure your environment. A basic example of this would be maintaining dev/test/production environments. Shifting a machine's distribution

Another example is maintaing a rolling set of updates

You can create additional distributions by adding ISOs you have downloaded or have created from a mirrored repository with the "stack create mirror" command. Either way, the iso is recognized as a pallet which can be enabled for the "default" distribution or enabled for a new distribution you have created. 