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

### Using the distribution

There's not much point in creating a distribution if you don't use it. So, let's use it.

% Assign backend nodes to the distribution

`# stack set host distribution backend distribution=test-dist`  
(Please note here "backend" is an appliance and will put all hosts of appliance-type "backend" into the "test-dist" distribution. I could have used a hostname or several hostnames or a hostname in regex here as well)

% Check host distribution  
`# stack list host`  

% Install/reinstall machines

`# stack set host attr backend attr=nukedisks value=true`  
`# stack set host boot backend action=install`  
`# stack run host "reboot"`  
(With `stack run host` not putting in a host designation will make it run on all hosts.)

Once the backend nodes install, they should have the new OS. Check /etc/redhat-release to verify.  
`# stack run host "cat /etc/redhat-release"`





