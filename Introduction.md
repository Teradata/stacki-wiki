# Stacki Introduction
Welcome to the Stacki Project! Our goal is to make fast,  repeatable, and adaptable Linux installations not only possible, but easy. 

It is quick and easy to get started spinning up Linux servers with Stacki, and advanced features let you go deeper and deeper into customizing installations so they are better suited for your specific environment.

Please direct questions/comments about this Introduction to the forum thread entitled “Stacki Documentation”, so others can benefit from your questions and insights.

###What is Stacki?
Stacki is a bare metal install tool that can take your machine/VM from hardware to working Linux, ready for you to install your applications. Advanced users can even have Stacki install their applications, but we’ll save that discussion for a different document. Stacki has a long history, and is in use at some of the most demanding organizations in the world. The commercial version of stacki is used by Fortune 500 companies to maintain their cloud and big data clusters, so it definitely has seen its share of production use.

What it does is simple, if it’s doing it for you…

1. Configure RAID controllers, if present.

2. Install OS.

3. Configure OS.

4. Configure networking.

5. Leave you to be productive.

And it does it fast. Of course, the speed of your disk drive matters when installing an entire OS, but Stacki is as fast as we can make it, and you can check out the source to see what we mean. If you want it faster, buy SSD. 

In theory, with Stacki, you could make machines disposable. “Give me a couple minutes, and we’ll check it out with a clean install”. Could be real.

And once Stacki is done, you’re ready to use whatever your application configuration toolset – be it puppet, chef, StackIQ Boss, whatever – to configure the rest of the system.

###Why Open Source?
It’s in our blood. StackIQ grew out of the Rocks Open Source project. Where Rocks focuses on High Performance Computing, StackIQ Boss specializes in clustered enterprise software – Big Data clusters and OpenStack. We wanted to offer the unserved portion of the world – the Linux server farm and individual developer – the same agility and performance that these two projects offer. So we created the Stacki project. The source is actually a streamlined version of StackIQ Boss, so has a long history of working in demanding environments.

###Linux? Which Linux?
Stacki currently supports RedHat and variants. Our How To documents and examples will generally use CentOS, but the commands will work on any of the RedHat derivative linux distributions.

###Getting Involved!
And now you can help make it better. Post suggestions, improve documentation, join the developers on GitHub (Link to GitHub). Any place you think you can help, that’s what this site and the forums are all about. As Open Source, it now counts on the support of the community to drive it farther. That’s you and me!


