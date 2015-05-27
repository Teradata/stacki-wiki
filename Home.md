![StackI Logo](https://github.com/StackIQ/stacki/blob/master/logo.png?raw=true)

# Introduction

Welcome to stacki.
Our goal is to make fast, repeatable, and adaptable Linux installations not only possible, but easy.

It is quick and easy to get started spinning up Linux servers with stacki, and advanced features let you go deeper and deeper into customizing installations so they are better suited for your specific environment.


## What is stacki?

stacki is a bare metal install tool that can take your server from bare hardware (or virtual machine) to working Linux, ready for you to install your applications.
stacki does this at scale, so deploying 100 servers is no more complex than deploying one.
Advanced users can even have stacki install their applications, but we’ll save that discussion for a different document. stacki has a long history, and is in use at some of the most demanding organizations in the world.
The commercial version of stacki is used by Fortune 500 companies to maintain their cloud and big data clusters, so it definitely has seen its share of production use.

What it does is simple:

1. Configure RAID controllers.

2. Install OS.

3. Configure OS.

4. Configure networking.

5. Leave you to be productive, to focus on more interesting problems.

With stacki, you cam make machines disposable.
Everything is built from the ground up programmatically so recovering from disasters can means just rebuilding the infrastrucutre.
Our goal is to keep you off of your servers and away from the question "what state are my servers in?".

And once stacki is done, you’re can augment it with your favorite configuration toolset - be it salt, chef, puppet, cfengine, or homegrown.

## Origins

Long before devops and webscale we were building world class supercomputers made from simple Linux boxes.
The hardware was cheap, but the complexity at scale killed us.
So we help create the [Rocks](www.rocksclusters.org) toolkit to automate the deployment of high performance computing clusters.
Along the way co-founders, developers, and users of Rocks started StackIQ to build upon the Rocks software and make it appropriate for the enteprise.
The lessons we've learned from large scale HPC and enterprise computing are now yours as part of stacki.

stacki is released as open-source with a combination of licenses.
StackIQ forked the Rocks project source code in 2010 but maintains the original copyright on this code.
As such the two primary licenses are for [StackIQ] and [Rocks] source,
both are based on the traditional BSD license.

stacki also includes several third party opensource packages each with their own copyrights.
Details on this are found in the source tree.

## Linux? Which Linux?

stacki currently supports RedHat and variants.
Our How To documents and examples will generally use CentOS, but the commands will work on any of the RedHat derivative linux distributions.

## Getting Involved!

And now you can help make it better.
Post suggestions, improve documentation, join the developers on GitHub (Link to GitHub).
Any place you think you can help, that’s what this site and the forums are all about.
As Open Source, it now counts on the support of the community to drive it farther.
That’s you and me!


