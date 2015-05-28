### Creating a pallet from a repository with a URL.

You've seen how easy it is to add an OS pallet from an existing ISO. It is possible, however, to create pallet ISOs from RPM repositories using the `stack create mirror` command. 

Getting and maintaining updates to the OS you want to install can be a bit frustrating. CentOS has a nice "updates" url we can use, so we'll pull the latest and greatest for 6.6. (RHEL is a little more complex since the move to Subscription Manager, but it's possible to pull updates with a properly subscribed machine. Documentation on how to do this is forthcoming.) 

The simplest of commands is to feed the `stack create mirror` command a URL to a repository. This will pull all RPMS in the specified URL. It is something of a hammer in a world of fine screws. 

% Get the url for the CentOS updates.
- http://mirror.umd.edu/centos/6.6/updates/x86_64/Packages/

% Create a mirror with this URL.

`# stack create mirror http://mirror.umd.edu/centos/6.6/updates/x86_64/Packages`

The default arguments to the command creates an ISO which can then be added like any other ISO.

Pretty much that's it. You'll get every updated 6.6 RPM in the CentOS updates repository. Since a distribution only gets the most recent version of an RPM you don't have to worry about conflicts. The most recent one of a same named RPM always wins. 

If you don't want the default naming scheme:

`# stack create mirror http://mirror.umd.edu/centos/6.6/updates/x86_64/Packages arch=x86_64 name=CentOS-updates version=05272015`

Which will create an ISO named updates and will show a version, in this instance, of today's date.

Now we need to make it available. 
% Add it
`# stack add pallet`

% Enable it
`# stack enable pallet`

% Recreate distribution
`# stack create distribution`

% Either yum update
`# stack run host "yum -y update"`

or

% Reinstall

`# stack set host boot backend action=install`
`# stack run host backend "reboot"` 

### Creating a pallet from a repository with a repoid.
