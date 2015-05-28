### Create a new distribution

A new distribution combines a set of application and OS pallets to install backend machines. Allowing for different versions of OS and applications to be on different machines for either testing or production services. 

This example will create a new distribution using RHEL 6.6 instead of CentOS 6.6. We'll then assign a machine to the new distribution.

% List distributions.  
`# stack list distribution`

![stack list distribution](images/stack-list-distribution-3.png)


% Create a new distribution  
`# stack add distribution test-dist`

![stack add distribution](images/stack-add-distribution-1.png)

and list it to verify:

`# stack list distribution` 

![stack list distribution](images/stack-list-distribution-1.png)
 

The "----"s indicate there are no pallets associated with the distribution, so add the minimum pallets: stacki and an OS pallet. Any applications pallets may be added too.

% Add pallets to the distribution.

See which pallets are available:

`# stack list pallet`

![stack list pallet](images/stack-list-pallet-2.png)

% Enable RHEL and stacki pallets.  
`# stack enable pallet stacki RHEL distribution=test-dist`        
(a version may be required using the "version=" argument. The version is shown in the output of `# stack list roll`)

![stack enable pallet](images/stack-enable-pallet-2.png)

% List to verify  
`# stack list distribution`

![stack list distribution](images/stack-list-distribution-2.png)

% Make the distribution  
`# stack create distribution test-dist`

![stack create distribution](images/stack-create-distribution-2.png)

### Using the distribution

There's not much point in creating a distribution if you don't use it. So, let's use it.

% Assign backend nodes to the distribution  
`# stack list host`  

![stack list host](images/stack-list-host-1.png)

`# stack set host distribution backend distribution=test-dist`  
(Please note here "backend" is an appliance and will put all hosts of appliance-type "backend" into the "test-dist" distribution. I could have used a hostname or several hostnames or a hostname in regex here as well)

![stack set host distribution](images/stack-set-host-distribution-1.png)

% Verify new host distribution  
`# stack list host`  

![stack list host](images/stack-list-host-2.png)

% Install/reinstall machines

`# stack set host attr backend attr=nukedisks value=true`  
`# stack set host boot backend action=install`  
`# stack run host "reboot"`  
(With `stack run host`, not putting in a host designation will make it run on all hosts.)

![stack host reinstall](images/stack-reinstall-1.png)

Once the backend nodes install, they should have the new OS. Check /etc/redhat-release to verify.  
`# stack run host "cat /etc/redhat-release"`

![stack verify](images/stack-distribution-verify-1.png)


### Removing a distribution

To remove a distribution, do the following:

% Reset the backend nodes to a valid distribution.  
`# stack set host distribution backend distribution=default`

![stack reset distribution](images/stack-reset-distribution-1.png)

% Remove the distribution and verify it is gone.
`# stack remove distribution test-dist`  
`# stack list distribution`  

![stack remove distribution](images/stack-remove-distribution-1.png)

There is a little more work do, however. A `stack add distribution` creates two directories that allow for customizing the software and configuration of the backend nodes. These directories sit under /export/stack/contrib/<distro_name/ and /export/stack/site-profiles/<distro_name>.

Keeping with this example, remove these two directories:

`# rm -fr /export/stack/contrib/test-dist`  
`# rm -fr /export/stack/site-profiles/test-dist`

![stack remove distribution](images/stack-reset-distribution-1.png)

% Reinstall backend machines

Since you've changed distributions on the backend machines, reinstall them as per the previous instruction.