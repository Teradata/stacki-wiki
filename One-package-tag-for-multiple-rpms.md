##### Can you put in a bunch of RPMS between two package tags in a kickstart file rather than having a bunch of package tags and one rpm name in-between?

So the answer is yes, you can.

This is what I currently do in one of my site-customization carts:

```
<package>mlocate</package>
<package>pciutils</package>
<package>yum-utils</package>
<package>foundation-wget</package>
```

And this is what I"m going to start doing:

```
<package>
mlocate
pciutils
yum-utils
foundation-wget
screen
tmux
</package>
```

Because, well, it works and it's less typing, and if a human only has a certain number of keystrokes in their wrists and fingers before debilitating injury. I have two keystrokes left.

You should still be able to use conditionals too:

I've set a key/value pair called "do_extras" and set it's value to "true"

```
# stack set attr attr=do_extras value=true
```

Set it to false for some of my backend nodes:

```
# stack set host attr backend-0-[0-2] attr=do_extras value=true
```

Now only put these RPMS on machines where "do_extras" is "true" (any backend but 0,1, and 2).

```
<package cond="&do_extras;">
mlocate
pciutils
yum-utils
foundation-wget
screen
tmux
</package>
```

I know, awesome right?