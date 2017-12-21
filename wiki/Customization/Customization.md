### Customize Backend Installs

Odds are good you're using Stacki because you have something in particular you
want to do. You're not doing this for the defaults.

The basic level of customization, and where you should start, is with a
[Cart](Carts). If you want to add software packages, run scripts during install,
pre-install, post-install, or first boot, it goes in a cart.

Adding software from various repositories can be done by [making software pallets](makeing-Software-Pallets). They are ideal for putting on software stacks created and verified by application developers or OS vendors or for adding updates to software you already have.

You can collect various pallets into [Boxes](Boxes) and assign hosts to boxes to get a particular stack of software that may be different from other nodes in your infrastructure.

So, really, start with [Carts](Carts). It will get you 90% of what you need.

If you need more software than just the minimal OS that comes with the Stacki default install. Got to [Creating Software Pallets](Creating-Software-Pallets) to download more of the CentOS distribution that you need.

If you have a customization questions, feel free to ask on stacki@googlegroups.com or our Slack channel.
