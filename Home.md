![stacki logo](https://github.com/StackIQ/stacki/blob/master/logo.png?raw=true)

Welcome to **stacki**.

Our goal is to make fast, repeatable, and adaptable Linux installations not only possible, but easy.

It is quick and easy to get started spinning up Linux servers with
stacki, and advanced features let you go deeper and deeper into
customizing installations so they are better suited for your unique environment.


## What is it?

Stacki is a bare metal install tool that can take your server from bare hardware (or virtual hardware) to working Linux, ready for you to install your applications.
Stacki does this at scale, so deploying 100 servers is no more complex (and barely slower) than deploying one.
Advanced users can even have stacki install their applications.
Stacki has a long [history](#origins), and is in use at some of the most demanding organizations in the world.
The commercial version of stacki is used by Fortune 500 companies to maintain their cloud and big data clusters, so it definitely has seen its share of production use.

What it does is simple:

1. Configure RAID controllers.

2. Install OS.

3. Configure OS.

4. Configure networking.

5. Leave you to be productive, to focus on more interesting problems.

With stacki, you cam make machines disposable.
Everything is built from the ground up programmatically so recovering from disasters can means just rebuilding the infrastructure.
Our goal is to keep you off of your servers and away from the question "what state are my servers in?".

And once stacki is done, you can augment it with your favorite configuration toolset - be it Salt, Chef, Puppet, CFEngine, or homegrown.


## Origins

Long before devops and webscale we were building world class [supercomputers](http://www.sdsc.edu) made from simple Linux boxes.
The hardware was cheap, but the complexity at scale killed us.
So we helped create the [Rocks](http://www.rocksclusters.org) toolkit to automate the deployment of high performance computing clusters.
Along the way we co-founders, developers, and users of Rocks started [StackIQ](http://www.stackiq.com) to build upon the Rocks software and make it appropriate for the enterprise.
The lessons we've learned from large scale HPC and enterprise computing are now yours as part of stacki.

### Opensource<a name="license"></a>

Stacki is released as opensource with a combination of licenses.
StackIQ forked the Rocks project source code in 2010 and maintains the original copyright on this code.
As such the two primary licenses are for [stacki](stacki-License) and [Rocks](Rocks-license) source,
both are based on the traditional BSD attribution license.
Stacki also includes several third party opensource packages each with their own copyrights.
Details on these are found in the [source tree](https://github.com/StackIQ/stacki).


## Linux

Stacki supports RedHat and its variants.
We generally develop on CentOS but we always test on RHEL to give you the choice of platform


