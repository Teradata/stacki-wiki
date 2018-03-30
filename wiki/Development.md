## Stacki Development

This document is primarily for core Stacki developers, but it also
applies to anyone contributing to Stacki, with the exception that
external contributions should all be pull requests.

### Coding Standards

#### Whitespace

A lot of our code is Python3, which means everyone needs to agree on
the tabs vs. spaces nonsense. We chose tabs, as in actual tab
characters for all indentation. If your favorite editor inserts
spaces when you hit tab, fix your editor.

#### IDE

ID-what? Use what ever you want, just follow the above rule.

#### Style

We need a real consensus on this, but right now the rule is when you
drop into a piece of code try to copy the existing style. For new code
just keep it readable. Eventually someone will get bored and write up
a style guide for Stacki, we will fight about it for a week or so and
loose interest and we will be back to where we are now. All of this
has happened before, and all of this will happen again.

There is a `.flake8` (think `pep8` with more stuff) in the Stacki
repository that turns off a lot of warnings related to whitespace. You
should run `flake8` often and fix reported issues when possible.

### Source Control Model

All of our Stacki code resides in Git, all of it, if it isn't in Git
it does not exist. If you have code that isn't in Git shame on you, if
you still work here shame on us. Keep your code in Git.

If you struggle with Git ask for help. Git isn't rocket surgery, but
it is at times magic.

Open-source is all on github.com and closed-source is all on our
private GitHub Enterprise, if you have doubts about something being
open-source put it in GHE first and then we can figure out what should
be open (Hint: usually everything). But just keep in mind, once it
goes to github.com the cat is out of the bag.

We follow the
[git-flow](http://nvie.com/posts/a-successful-git-branching-model)
branching model. This doesn't mean everyone actually uses `git-flow`,
but everyone follows the [model](https://danielkummer.github.io/git-flow-cheatsheet).
Which means the repository always has both a `master` and `develop`
branch. So to checkout the code you will always have to checkout both
branches. The idea is development happens in `develop` and only
released code ever makes it to `master`.

```
$ git clone git@github.com:Teradata/stacki.git
$ cd stacki
$ git checkout -b develop origin/develop
```

You are also encouraged to use `git-flow` which requires you to
initialize the repository after a fresh clone. But, before you even do
that you may need to install `git-flow` on your machine, which means
grabbing the [source](http://github.com/nvie/gitflow). Yeah, it's an
old project of crusty shell code.

```
$ git-flow init

Which branch should be used for bringing forth production releases?
   - develop
   - master
Branch name for production releases: [master]

Which branch should be used for integration of the "next release"?
   - develop
Branch name for "next release" development: [develop]

How to name your supporting branch prefixes?
Feature branches? [feature/]
Release branches? [release/]
Hotfix branches? [hotfix/]
Support branches? [support/]
Version tag prefix? []
```

#### Feature Branches

All development should be done on feature branches. Once a feature is
ready to be shared with the team and has passed the nightly build and
test system it can be added to the list of branches to be merged back
onto `develop` during the team's weekly merge party. Exceptions will
happen but the general rule here is always stay on a feature branch,
and merge back only as a group.

To start a feature branch:

```
$ git flow feature start name-of-feature
```

While you are developing on your feature branch remember to merge
`develop` back onto your branch often. Failure to merge often will
result in the amusement of your co-workers while you struggle with a
10,000 line merge conflict.

#### Code Review

The next step to getting your feature back into the `develop` branch
is an optional code review, not everything will go through this but it
is encouraged and sometimes required. Features will usually get
identified as code review candidates during the Merge Party.

If your feature branch requires a code review the group will identify
the person to review and they are then responsible for going through
the code and giving the all clear before the code makes it to the next
Merge Party.

If you think your code is more in the *works for me* state, you need a
code review. It happens to all of us, own up to it and ask for
help. If you don't know if your code needs review, it needs review.

#### Merge Party

Every week or so every developer with a completed feature will sit in
a room together and discuss and merge their branches back onto
`develop`, and immediately get `develop` back into the build and test
system. Not all features invited to the party get merged, some get
pushed back to code review, and some may get defered for a later
party.

	next merge party will document the process


### Release Branches

Releases begin after the desired feature branches are all merged onto
the `develop` branch and it has been tested in the nightly build and
test system. The release process begins with a fresh clone on the
Stacki repository, and since we are releasing from the `develop`
branch that needs to be checked out as well. We know, it's perfectly
safe to start from an existing repository, but don't.

```
$ git clone git@github.com:Teradata/stacki.git
$ cd stacki
$ git checkout -b develop origin/develop
```

Unlike the development process, during we release we strictly require
the use of `git-flow` to start a new release branch and eventually
merge everything back onto `develop` and `master`. *Note* that we
accept the default values for all of `git-flow init` except for the
`Version tag prefix` which should be set to `stacki-` (yes you need
the dash).

```
$ git-flow init

Which branch should be used for bringing forth production releases?
   - develop
   - master
Branch name for production releases: [master]

Which branch should be used for integration of the "next release"?
   - develop
Branch name for "next release" development: [develop]

How to name your supporting branch prefixes?
Feature branches? [feature/]
Release branches? [release/]
Hotfix branches? [hotfix/]
Support branches? [support/]
Version tag prefix? [] stacki-
```

Next we decide on the name for the release (e.g. 5.1rc1) and start the
release. This will create a new local branch called `release/5.1rc1`
based on `develop` and checkout the branch.

```
$ git flow release start 5.1rc1
```

This is when the version number is changed, in `stacki/version.mk`
change the `ROLLVERSION` variable to the release name (e.g. 5.1rc1)
and checkin the change with a comment indicating the release is started.

```
$ vi version.mk
$ git add version.mk
$ git commit -m "starting release 5.1rc1"
```

Once the release is started only bug fixes are allowed to be checked
into the release branch. Development on feature branches and merge
parties continue, and have no impact on the release branch. Bug fixes
may be direct commits to the release branch or cherry-picked commits
from other branches.

But first push the branch back to the origin so everyone sees it.

```
$ git flow release publish 5.1rc1
```

Once all bugs are squashed and the code is ready to ship the
branch is merge back onto both `develop` and `master`, this ensures
any bugfixes applied only to the release branch go back into `develop`
and that `master` only contains released code. Finishing the release
will also create a an annotated tag based on the release name (in this
example the tag will be `stacki-5.1rc1`) which means it will ask for a
comment (same as doing a `git commit`). This message is stored and can
be accessed with `git show stacki-5.1rc1`).

The following will finish the release, or as we say *tag it, and bag it*.

```
$ git flow release finish 5.1rc1
$ git push
$ git push --tags
```









