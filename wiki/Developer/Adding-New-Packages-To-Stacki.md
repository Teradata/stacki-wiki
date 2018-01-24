## Adding new packages to Stacki


To be clear, this page is targeted to developers and intended to explain how to add new packages to Stacki itself.  If you're a Stacki user trying to figure out how to make new packages available to your backend nodes, please see [Adding-RPMs](Adding-RPMs).

Stacki developers (or pallet developers trying to follow best practices), keep reading.

Adding a new package to stacki might appear confusing or daunting, but there's actually a few fairly simple rules.

Is this someone else's code, or is it code that we wrote?  Does this package conflict with an OS-provided package?  Should this package be installed on the frontend, the backend, both?  And should it be installed by default, or simply available if the user wants it?  Should this package exist in the installation environment?  Is the package needed on multiple OSes?  Can it be installed via `pip`?  There's a lot of questions here, but they should almost always be simple to answer.

## Where do you put the code itself (and the build instructions)?

### Code that we wrote

This is an extension to stacki that didn't fit in the command-line or pylib, etc.  The code itself should have its own sub-directory in `common/src/stack/`.  Installation images are the exception to this, and will go under `$OS/`.  If you don't already have a `makefile` and `version.mk` (`version.mk` can be empty) that works, copy them from a sibling directory and tweak until they do.

### Someone else's code (something like Redis, or PostgreSQL)

Hey, it's cool, don't reinvent the wheel (unless the wheel you found sucks, then super re-write that wheel).

#### Is it `pip` install-able?

Add it in `common/src/foundation/python-packages/packages.json` and `common/src/foundation/python-packages/versions.json` and move on to the next section.

#### All other other-people's-code

0. Obviously, make sure we have legal permission to redistribute this code.  Duh.

1. Create a directory, `$OS/src/foundation/$PKG_NAME` for the package.  If the package is needed or useful for any OS, put it in `common/src/foundation` -- this should be the default unless there's good reason!

2. In `$OS/src/foundation/$PKG_NAME`:

    1. Put a copy of the license called `LICENSE.txt`.

    2. Create a symlink named after the tarball of the source (for example `mariadb-10.2.6.tar.gz`) which points to `../../../3rdparty/mariadb-10.2.6.tar.gz`.  This directory will be populated by make 3rdparty, which should be called before Stacki itself is built and will fetch the actual .

    3. Create a `makefile` which has the full instructions for how to go from tarball to built binary.  It's probably easiest to look around other foundation packages to find a makefile that builds a package the same way yours builds.

    4. Create a `version.mk`, which in 90% of cases, just contains the version number as it appears in the tarball filename

3. In `$OS/`, add an entry in `3rdparty.json` and `3rdparty.md`.  Keeping the filenames the same is important!

4. Upload the tarball source if possible - or the RPM if not - to S3 in the `baseurl` location from 3rdparty.json

## Whoever's code it is, making sure the build doesn't fail

Our build environment will double check it's work.  After building stacki, or any pallet, you can run `make manifest-check` (and our CD/CI server does exactly that) to make sure that all packages that were expected were built, and all packages that were built were expected.

In order to generate that list, Stacki has a manifest.  If your thing is in `common`, then add the package name to `common/manifest.d/common.manifest`.  You'll probably also need to add a line subtracting it from `common/manifest.d/common.sles11`.  The same structure is in `sles/manifest.d` for SLES-only packages.  At the time of this writing, the RHEL-family is just `redhat/manifest`, but this may get moved over to the `manifest.d` style.

## Deploying the code

If you merely want the package available for install but not installed automatically, skip this section.

### Node and Graph files

To actually have the code deployed by default, you need to plumb it into the XML graph.  This requires a little knowledge about the graph, though you probably don't need to modify the graph itself.  In general, some XML files are only rendered for frontends, some for backends, and some for both, and some only for certain OS's.  Basically, find a node xml file in `$OS/nodes/` (again, preferring to keep things in the `common` directory) that matches the purpose of your code, and preferably already has a package install section.

Somewhere in the xml file, probably toward the top, you should include a package install xml tag like so:

```
<stack:package>$MY_PACKAGE_NAME</stack:package>
```

where `$MY_PACKAGE_NAME` is the name of your package as it would be recognized by a package manager.  Keep in mind if you put it in foundation and it was a tarball, the package name will almost certainly start with `foundation-`.  For example, `common/src/foundation/mariadb` becomes `foundation-mariadb`.

### Wait, my thing needs to be in the installer.

For CentOS/RedHat, you need to add the package tag in a few places:

```
redhat/src/stack/images/Makefile
redhat/src/stack/images/$LATEST_VERSION/initrd.img/version.mk
redhat/src/stack/images/$LATEST_VERSION/updates.img/version.mk
```

For SLES:

```
TODO
```
