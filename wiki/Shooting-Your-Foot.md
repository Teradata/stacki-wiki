### Things you can do but probably shouldn't..

We have a sayin' 'round these parts. (Well, I have a saying.)

"Stacki gives you the gun, you have to find your foot."

There are some advanced techniques that we sometimes use and sometimes tell our users to use, because we want them to go away.

These are not guaranteed to work for you. You should have fairly deep experience with Stacki and want to do something the Stacki doesn't currently do natively.

You're forewarned and apparently armed, your foot is down. Help is in Stacki Slack or Googlegroups, but man, are we gonna laugh.


### Don't decide you want a different private network

You read the warnings right? Get the *private* network correct. The right answer is to reinstall if you didn't. Seriously, you'll be happier, and we'll support you if you do that. We won't if you decide to attempt to change everything on the frontend that would need to change in order to fix your private network.

### Don't change the /root/.ssh/id_rsa.pub key.

Don't change the permissions on it. They should be 644 or rw-r--r--. This is what gets put into /root/.ssh/authorized_keys on the backend nodes. If you change the permissions to something more restrictive...Bang! no password-less ssh to the backends.

Don't. Do. It. Dammit.

# Using additional repositories

Using the Centos*.repo files are a recipe for disaster. If you feel you must use them, considering mirroring the repository and adding them as pallets as described in [Creating Software Pallet](Creating-Software-Pallets).

If you don't want to do that, then Stacki is likely not the solution you are looking for. Do more research for something more suitable for your site. 

Try:
* [Digital Rebar](http://rebar.digital/)
* [Cobbler](https://cobbler.github.io/)
* [Spackewalk](https://spacewalkproject.github.io/)
* [MaaS](https://maas.io/)
* [Rocks](https://rocksclusters.org) for HPC.
