We use spreadsheets - CSV spreadsheets to be specific.

You're laughing it up fuzzball.

Let's imagine an almost universal, easy to understand, easy to use, relatively compact, explicitly structured way to represent data about all the stuff we have and how it should be configured that even the marketing idiot in the cubicle on A2 could create or load if we trusted him that much. (We actually don't trust him, that's an example of hyperbole.) What comes to mind?

Yeah, CSV - that's why we use spreadsheets.

Stacki loads and unloads data in spreadsheets for hosts, networks, storage controllers, and storage partitions. It allows you to do all the preparation to automate the deployment of a data center.

And it's not YAML.

There are examples and details in:

* [Configure Additional Networks](Network-Configuration)
* [Configure Partitioning](Partitioning-Configuration)
* [Configure Storage Controller](Storage-Configuration)
* [Adding Hosts](Backend-Install-Spreadsheet)

Using a spreadsheet for specifying host, network, controller, and disk configuration is considered a *Stacki best practice*. You might hate them (I don't, I like commas.) but loading spreadsheets:

* Makes you explicitly define your configuration.
* Validates the configuration.
* Saves it in RCS (yeah, we're that old) so you can roll back or blame someone.
* Syncs the database and the configuration, which saves time, steps, and potential human errors versus the command line.

Use a spreadsheet.
