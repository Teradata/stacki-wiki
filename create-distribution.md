### Create a new distribution

A new distribution combines a set of application and OS pallets to install backend machines. Allowing for different versions of OS and applications to be on different machines for either testing or production services. 

This example will create a new distribution using RHEL 6.6 instead of CentOS 6.5. We'll then assign a machine to the new distribution.

% Create a new distribution
`# stack create distribution name=test-dist`

% Add pallets to the distribution.

A distribution requires an OS pallet and the stacki pallet. Any other available application pallets can be added also.

See which rolls are available:

`# stack list roll`

% Enable RHEL and stacki pallets.  
`# stack enable pallet stacki RHEL distribution=test-dist    
(a version may be required using the "version=" argument. The version is show in the output of `# stack list roll`

% Make the distribution  
`# stack create distribution name=test-dist`



