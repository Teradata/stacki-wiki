## Include directive

**Note:** This is not verified for any other OS other than RHEL variants.

Can I use the %include to use files I already have without having to rewrite them in Stacki xml format?

## Global kickstart directory

Typically with kickstart, you rebuild the initrd.img to include the files that you want to pull in the %pre or %post stanzas of the kickstart file. That's not practical with Stacki and is way more work than you probably want to do.  However, the %include directive allows you to use a url to pull files from the webserver, which you have. On the frontend.

So let's use that. I'll do this in the context of a site-customization cart, but you don't have to put the files into a cart - you can just drop them in a directory within the /export/stack tree.

The /export/stack directory maps to http://&lt;frontend ip&gt;/install during installation. You could put all your kickstart files in a directory under /export/stack/ksfiles (or name your own directory) and then these will be available during kickstart installation here: http://&lt;frontend ip&gt;/install/ksfiles/&lt;somefilename&gt;.

For example if I had a kickstart file called "my-site-kickstart.txt" I could put it in /export/stack/ksfiles/my-site-kickstart.txt and call it in the kickstart with this:

%include http://&lt;frontend ip&gt;/install/ksfiles/my-site-kickstart.txt

and it would be included during install.

I'll give a solid example based on a site customization cart, which is typically where I need to put changes that are local to the client I'm working with or a set of systems I'm working with. The above example is for doing this globally. This example does it localized to a cart. You can use either one, or both if you must.

If you go this route, make sure you do a:

```
chgrp -R apache /export/stack/<new dir>
```

Or the kickstart won't pull the files you've indicated.

## Using %include in cart.

When you create a cart with:

```
stack create cart <cart name>
```

You get a particular directory structure and an entry in /etc/yum.repos.d/stacki.repo that maps to the url for that cart. This means the cart directory structure itself is reachable during the install via url. So we can use %include directives to get files.

So we'll put kickstart files that have already been created by us and include them in our cart kickstart files. It's easier to use an example. So I'll walk you through what I did, and then you can make the abstraction for your site.

% Create a cart

```
stack create cart site-customization
```

and enable it:

```
stack enable cart site-customization
```

Go to the cart directory, list it, and create a "files" directory.

```
cd /export/stack/cart/site-customization

[root@stacki37 site-customization]# ls
fingerprint  graph  nodes  repodata  RPMS

mkdir files

[root@stacki37 site-customization]# ls
files  fingerprint  graph  nodes  repodata  RPMS

```

Put your kickstart files in the "files" directory and cd to the "nodes" directory.

There should be a file named cart-&lt;cart name&gt;-backend.xml. In my example it's: cart-site-customization-backend.xml.

I have a kickstart file called "testfile" in the "files" directory. I want to call that during the post section. So in my cart-site-customization-backend.xml file, I'll call that file with a %include directive. It looks like this:

```
<stack:script stack:stage="install-post">
<stack:file stack:name="/etc/systcl.conf" stack:mode="append">
kernel.sysrq = 1
</stack:file>

%include http://10.1.1.1/install/carts/site-customization/files/testfile
</stack:script>
```

If I had a file named testfile-pre I needed to run during the &lt;stack:stage="install-pre"&gt; section, I would use the same syntax like this:

```
<stack:script stack:stage="install-pre">
%include http://10.1.1.1/install/carts/site-customization/files/testfile-pre
</stack:script>
```

There may be some caveats I am not aware of, so give it a shot and let us know on the stacki list and ask for help if you need it.
