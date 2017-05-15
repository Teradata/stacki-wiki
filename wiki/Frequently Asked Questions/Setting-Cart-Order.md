### Getting the Order You Want for Your Carts

I've been asked the same question twice in the past month so I figured I would record it for posterity.

If you add a couple of carts and enable them on a box, they are picked up in alphabetical order. So when you add a cart with a sensible name, what if you want to run one before the other?

I'll create and enable two carts, "custom1" and "custom2." (You should use something descriptive for your site that tells anyone who has to manage this infrastructure exactly what is in the cart, like: "puppet" or "ddosattack" [Hi NSA!] or "stupidcrapymycompanymakesmeinstall.") 

Without any ordering changes, this is the order these two carts will have when a kickstart is generated:

```
# stack list host profile backend-0-2 | less

<snip>
/export/stack/carts/custom1/nodes/cart-custom1-backend.xml
/export/stack/carts/custom2/nodes/cart-custom2-backend.xml
/export/stack/pallets/stacki/3.3/7.x/redhat/x86_64/nodes/base.xml
/export/stack/pallets/stacki/3.3/7.x/redhat/x86_64/nodes/postshell.xml
</snip>
```

( ```# stack list host profile <nodename>``` reveals the kickstart that will be generated and run during install. The "Node Traversal Order" at the beginning of this output, tells you what order kickstart snippets [in xml files] are compiled into the full kickstart script.)

Okay, so let's say we want the "custom1" cart to follow the "custom2" cart. We are going to manipulate the graph file in the "custom1" cart to get the order we want. So we are going to manipulate the order for the cart that we want to be second.

(Graph files place a node xml into the kickstart profile for a machine. These are compiled as long as the cart is enabled. Disable the cart, the graph file and, hence, the kickstart node xml files, are not compiled into the kickstart profile.) 

Go into the graph directory of the "custom1" cart:

```# cd /export/stack/cart/custom1/graph```
 
and get into the cart-custom1.xml

It will look like this:
```
<?xml version="1.0" standalone="no"?>
<graph>

    <description>
        custom1 cart
    </description>

        <order head="backend" tail="cart-custom1-backend"/>
        <edge  from="backend"   to="cart-custom1-backend"/>

</graph>
```
and these are the lines we care about:

```
  <order head="backend" tail="cart-custom1-backend"/>
  <edge  from="backend"   to="cart-custom1-backend"/>
```

Every cart has an "order" tag and an "edge" tag.

The "order" tag tells this cart what it should follow if it has a "tail" in it and what to precede if it has a "head" in it.

The "edge" tag tells what node xml file (Those are in the "nodes" directory in your cart.) should be used in the graph. The order will tell the kickstart compiler where to place it.

So to have "custom1" follow "custom2," we would edit it this way:

```
  <order head="cart-custom2-backend" tail="cart-custom1-backend"/>
  <edge  from="cart-custom2-backend" to="cart-custom1-backend"/>
```

Which gives us this:

```
# stack list host profile backend-0-2 | less

<snip>
/export/stack/pallets/stacki/3.3/7.x/redhat/x86_64/nodes/do-partition.xml
/export/stack/carts/custom2/nodes/cart-custom2-backend.xml
/export/stack/carts/custom1/nodes/cart-custom1-backend.xml
/export/stack/pallets/stacki/3.3/7.x/redhat/x86_64/nodes/base.xml
/export/stack/pallets/stacki/3.3/7.x/redhat/x86_64/nodes/postshell.xml
</snip>
```

There are other ways of doing it. What I showed is the simplest and easiest to understand.

Now we can get weird about it. 

You can also do something like this:

```
  <order head="backend" tail="cart-custom1-backend"/>
  <edge  from="cart-custom2-backend" to="cart-custom1-backend"/>
```

Which will give you the same thing. but it's more obscure and it depends
on the sure knowledge that ordering for "cart-custom2" is tailed to "backend," 
which it is by default unless one of your co-workers/buddies changed it just because.
 
So this way is indirect. I recommend the first way because it's obvious this way,
and it assures that cart1 will always follow cart2 even if someone messes with the
ordering in cart2's graph. Capisce?

We can get even weirder and edit "custom2" to always be the head to "custom1," but then we're just being fancy.

#### Additional carty-shtuff:

Please note, you can also overwrite or extend an xml that stacki provides by doing
a replace-`<xml file name`>.xml or extend-`<xml file name`>.xml in a
customized cart without having to manipulate order or edges.

Example:

If you want to do something for ssh on the backend nodes for instance. You can
replace it by creating a replace-ssh-client.xml and put your own ssh set up there.
Drop the file in the "nodes" directory under a cart and then

```
# stack list host profile backend-0-2 | less
```

will show this:
```
<snip>
/export/stack/pallets/stacki/3.3/7.x/redhat/x86_64/nodes/selinux.xml
/export/stack/pallets/stacki/3.3/7.x/redhat/x86_64/nodes/ssh.xml
/export/stack/carts/custom1/nodes/replace-ssh-client.xml
/export/stack/pallets/stacki/3.3/7.x/redhat/x86_64/nodes/ssl.xml
</snip>
```

You can use the extend-ssh-client.xml in the same way if you just want to append or
add to the ssh configuration on the clients. This works with any file in the graph provided
by us or provided by a cart someone at your site created. 

You can also use conditionals in graph files. But that's a topic I'll address only when
someone asks me for it, twice.

