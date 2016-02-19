##### Kickstart has an %include directive to include files into the kickstart. Can I use the %include to use files I already have without having to rewrite them in Stacki xml format?

Well, yeah. There is actually an <include> tag that I think does this. But I haven't been able to figure out how that works. When I do, we'll probably amp its capability, and we'll post how to use it. In the meantime, this is how you can use %include directives.

##### Global kickstart directory

Typically with kickstart, you rebuild the initrd.img to include the files that you want to pull in the %pre or %post stanzas of the kickstart file. That's not practical with Stacki and is way more work than you probably want to do.  However the %include directive allows you to use a url to pull files from the webserver, which you have. On the frontend.

So let's use that. I'll do this in the context of a site-customization cart, but you don't have to put it into a cart.

The /export/stack directory maps to http://<frontend name or ip>/install during installation. You could put all your kickstart files in a directory under /export/stack/ksfiles (or name your own directory) and then these will be available during kickstart installation here: http://<frontend name or ip>/install/ksfiles.

For example if I had a kickstart file called "my-site-kickstart.txt" I could put it in /export/stack/ksfiles/my-site-kickstart.txt and call it in the kickstart with this:

%include http://<frontend name or ip>/install/ksfiles/my-site-kickstart.txt

and it would be included during install. 

I'll give a solid example based on a site customization cart, which is typically where I need to put changes that are local to the client or set of systems I'm working with. The above example is for doing this globally. This example does it localized to a cart. You can use either one, or both if you must. We'll probably develop something that's easier post v3.0 so stay tuned. 

##### Using %include in cart.

When you create a cart with:

```
stack create cart <something>
```

You get a particular directory structure and an entry in /etc/yum.repos.d/stacki.repo that maps to the url for that cart which means the cart itself is reachable during the install via url. So we can use %include directives to get files.

So we'll put kickstart files that have already been created by us and include them in our cart kickstart files. It's easier to use an example. So I'll walk you through what I did, and then you can make the abstraction for your site. 
