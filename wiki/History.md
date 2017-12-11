### History

Deep in the dark days of scientific computing, long before DevOps and webscale, scientists were building world class [supercomputers](http://www.sdsc.edu) made from simple Linux boxes. Hardware was cheap, but managing complexity at scale was disastrous. So the eventual founders of Stacki helped create the [Rocks](http://www.rocksclusters.org) toolkit to automate the deployment of high performance computing clusters.

[Rocks](www.rockclusters.org) from UCSD is an open source CentOS/RHEL cluster distribution built for the HPC. The purpose is simple, get a cluster up and running quickly and easily so scientific computing jobs could be run by anyone at the institution and do it a large scale. From the simple purpose, thousands of clusters were installed all over the world to meet the computing demands of the internet era.

Light was created in the dark HPC world. It was beautiful. It was good. It was open source.

Which meant if there was proprietary vendor software your institution needed, it couldn't be shipped with Rocks or be supported by Rocks.

The founders of StackIQ, before Stacki was a thing, founded Clustercorp, a now defunct company :cry:, to provide support for Rocks and proprietary software stacks.

Unfortunately, educational institutions and national labs don't spend money on software. They have people, who are never going to leave, so make them do something. Installing clusters is one of those somethings.

Clustercorp forked themselves into StackIQ and forked the Rocks software to create Stacki. (This is called a "pivot" for you young kids out there.)

The founder of ClusterCorp and a couple of the Rocks founders started StackIQ to build on the Rocks software and make it appropriate for the enterprise. This produced software capable of managing the data center and the modern apps you have grown to ~~detest~~ love: OpenStack (wait someone loves OpenStack), Hadoop, Cassandra, all the NoSQL, Puppet, Chef, Ansible, all the DevOp, etc. etc.

It's Linux. If you can do it Linux, you can do it across a couple thousand machines in about the time it takes to drink a pot of coffee. (Faster if you drink the pot of coffee before installing.)

Which is why Teradata bought StackIQ and left Stacki open source. Because who doesn't want a piece of this Awesome?

The End
