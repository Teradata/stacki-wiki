#### Replacing and extending default XML.

There may be times where you don't want or don't like or want to add to the configuration of a service Stacki takes care of.

You can always see what XML snippets containing kickstart that are installing by doing:

```
# stack list host profile <hostname>
```

on the frontend for a host you want to install. You're looking for the "info - parsed" lines. These tell you, in order, what files have kickstart code that are going to compiled into the kickstart file the node receives.

You can overwrite or extend an xml that stacki provides by doing a replace-`<xml file name`>.xml or extend-`<xml file name`>.xml in a
customized cart without having to manipulate order or edges.

Example:

If you want to do something for ssh on the backend nodes for instance. You can
replace it by creating a replace-ssh-client.xml and put your own ssh set up there.

Drop the file in the "nodes" directory under a cart and then:

```
# stack list host profile backend-0-2 | less
```

will show this:
```
<snip>
info  - parsed pallets/stacki/5.0_20171128_b0ed4e3/redhat7/redhat/x86_64/nodes/selinux-base.xml
info  - parsed pallets/stacki/5.0_20171128_b0ed4e3/redhat7/redhat/x86_64/nodes/ssh-base.xml
info  - parsed carts/custom1/nodes/replace-ssh-client.xml
info  - parsed pallets/stacki/5.0_20171128_b0ed4e3/redhat7/redhat/x86_64/nodes/ssl-base.xml
</snip>
```

You can use the extend-ssh-client.xml in the same way if you just want to append or add to the ssh configuration on the clients. This works with any file in the graph provided by Stacki or provided by a cart someone at your site created.

You can also use conditionals in graph files. But that's a topic I'll address only when someone asks me for it, twice and I'm able to move the jaguar sitting on top of my keyboard.
