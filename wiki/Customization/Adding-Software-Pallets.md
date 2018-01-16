### Creating Software Pallets

There may come a point where it makes sense to create your own pallets. There are three types: RPM only, configuration only, and configuration + RPMS.

Pallets allow you to install and configure applications you have created or downloaded. It's a simple way to keep multiple versions or to do patching/upgrading.

All pallets come in the ISO format. They can be pulled from the web for OS distributions or created from a directory or remote yum/zypper repository by mirroring.

RPM-only pallets are the simplest to create.

##### RPM-only Pallet

Creating an RPM-only pallet is simple and assumes your frontend has access to the internet. If not, put up a VirtualBox frontend on your desktop/laptop and create the pallets there and then put them on the real frontend.

###### Creating pallet from a URL.

Let's say I want all of EPEL. (This is actually easier to do with repoconfig/repoid from EPEL but I want an example.)

If I have a url, I can use that with my `create mirror` command to get the packages.

Here's the epel url:
Again, go to your biggest directory:
```
# cd /export
```

Mirror using the url=https://mirrors.sonic.net/epel/7/x86_64/Packages/

*Note:* When you use a "url=" parameter `stack create mirror` uses "wget" and NOT reposync. Use the "url" for RPMS not in actual repositories with a repoconf/repoid.

```
# stack create mirror url=https://mirrors.sonic.net/epel/7/x86_64/Packages/ name=epel version=20171128 quiet=false
```

Wait a looonnnnnggggg time.

At some point you'll see this output:
```
Creating disk1 (0.00MB)...
Writing repo data
Spawning worker 0 with 883 pkgs
Workers Finished
Saving Primary metadata
Saving file lists metadata
Saving other metadata
Generating sqlite DBs
Sqlite DBs complete
Copying graph and node XML files
Building ISO image for disk1
```

Which means the ISO is built.

###### Creating pallet from a repoid.


Sometimes there's an application you want to install, and a repoconfig file
exists for it.

For this example we'll use Apache Cassandra.

Go to the [Cassandra](https://cassandra.apache.org/download/) install docs. You'll notice about half-way down they give you the repoconfig you'll need to get this from yum.

Cut and paste that and put it in a file. I've put it in /export/cassandra.repo.

```
# cat /export/cassandra.repo

[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
gpgcheck=1
repo_gpgcheck=1cat
gpgkey=https://www.apache.org/dist/cassandra/KEYS
```

Let's do a few things:
* I'm going to feed the name of this file to "repoconfig" parameter to get all the needed Cassandra RPMs.
* The version is "311x" because that's the lastest version of Cassandra.
* The "repoid", in this case "cassandra," tells "create mirror" the repo to pull from. Some repoconfigs might have more than one stanza - CentOS-Base.repo is a good example.
```
# stack create mirror name=apache-cassandra version=311x repoconfig=/export/cassandra.repo repoid=cassandra quiet=false
```

Now breathe. In/out. Long deep breaths. Or, hell, just go get another cup of coffee. When it's done you should see something like this:
```
# ls cassandra
apache-cassandra-311x-redhat7.x86_64.disk1.iso  cassandra-3.11.1-1.noarch.rpm  cassandra-tools-3.11.1-1.noarch.rpm  roll-apache-cassandra.xml
```

Note, the directory is the name of the "repoid" and the newly created file is in this directory.

Do the add/enable pallet dance:

```
# stack add pallet cassandra/apache-cassandra-311x-redhat7.x86_64.disk1.iso
Copying apache-cassandra 311x-redhat7 to pallets ...

# stack enable pallet apache-cassandra
Cleaning repos: CentOS-7-redhat7 CentOS-Updates-7.4_20171128-redhat7 apache-cassandra-311x-redhat7 epel stacki-5.0_20171128_b0ed4e3-redhat7
Cleaning up everything
Maybe you want: rm -rf /var/cache/yum, to also free up space taken by orphaned data from disabled or removed repos
```

Now you can use the Apache Cassandra RPMs on the cluster. Use a cart and `<stack:package>` tags to add the software and `<stack:file>` tags to add config files, and `<stack:script>` tags to enable the service and configure any other dependences.

All this set-up can be found in the Apache Cassandra docs and can be converted to your cart xml.
