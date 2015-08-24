
Add the RPMS to

/export/stack/contrib/default/1.0/x86_64/RPMS/

And then do:

# stack create distribution

Now they're available for a: 

# stack run host "yum -y install <rpm name>"  

on the backend nodes. 

They're also available during installs if you add the name of the package to package tags in the extend-backend.xml.

So

<package>myrpmname</package>

Thanks,

Joe