<h5>The Guide to Installing Ubuntu with Stacki</h5>

In almost every meet-up and conference one of us has spoken at in the last 6 months, there is always at least one guy who asks "Can you install Ubuntu"? And the answer for the past 6 months has been "No, we don't." <sup name="a1">[1](#f1)</sup>

Until today. <sup name="a2">[2](#f2)</sup>

Okay, well mostly. I'm going to give you all the caveats first, and then if you really want to go down this road, it's less painful now because I walked it for you.<sup name="a3">[3](#f3)</sup> And I would be really excited to work on making it great with any community members who would like to spend some time on it. 

Installing Ubuntu, much like the installation of CoreOS, is a Phase 1 project. <sup name="a4">[4](#f4)</sup> A Phase 1 project for us means: it's going to work, at least as good as what you have, possibly simpler or better than what you have, but it will work. You'll be able to install backend nodes with the version of Ubuntu you want, while still maintaining your CentOS/RHEL stack.

Phase 1 does not have any of the special things we do for CentOS/RHEL variants: disk controller configuration<sup name="f5">[5](#a5)</sup>, parallel disk partitioning, automatic kickstart generation, parallel file-sharing of packages, and the use of attributes to dynamically populate values in kickstart or preseed. Those pieces are for Phase 2, assuming there is sufficient sturm und drang to push us to get there.

This tutorial will follow the same basic outline as CoreOS. Both are effectively the same procedure we use for prototyping any new OS or application we are automating:

- Get the software.
- Set up the bootaction.
- Put the files into tftp.
- Create a preseed.cfg
- Set machines to boot from the bootaction.
- Install
- Validate
- Bask in Ubuntuness
- Turning it to 11
- Future directions.


<h5>Future Directions</h5>

<h6>Footnotes</h6>

<sup name="f1">[1](#a1)</sup> One of you is going to say "What about SUSE?", and I'm going to say that when I drive by the Novell campus there are coyotes chasing tumbleweeds where a company used to be, and I've never been to Germany. Make an argument for the need, and we'll start a Phase 1 and see how far it goes. Or we'll help you start a Phase 1 project and see how far it goes. Or, write us a check, and we'll have you believing in magic again.<sup name="b1">[1](#g1)</sup>

<sup name="f2">[2](#a2)</sup> Cue thunderous applause.

<sup name="f3">[3](#a3)</sup> And, I, might add, left it on the mat, put my heart and soul into it, laughed, cried, became a part of it, spilt my life's blood, cursed the Gods on your behalf all while wondering how anyone has been able to install an entire cluster of this OS in a timely fashion - for you, yes you, that guy who always asks me: "Can I install Ubuntu?"

<sup name="f4">[4](#a4)</sup> Meaning, that it's going to work, it will have some special sauce, but the two whole beef patties will be missing, which means you can eat it but you'll be wondering where the beef is.

<sup name="f5">[5](#a5)</sup> Okay, so disk controller set-up is a killer problem. If you really want the RAID setup correctly, import the controller setup in a spreadsheet, install the backend nodes with CentOS/RHEL, and then reinstall them with this procedure for Ubuntu. Magic. You have your controllers set-up and you have Ubuntu. The Ubuntu install takes longer but you'll have the RAID set-up the way you expect with the small constraint of having an extra install. But that takes what, 10-15 minutes for as many nodes as you have?

<h5>Footnotes to the Footnotes</h5>

<sup name="f1">[1](#g1)</sup> Once the check has cleared.
