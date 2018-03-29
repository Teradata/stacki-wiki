## Stacki Development

### Source Control Model

All of Stacki code resides in git. Opensource is all on github.com and
closed source is all stored in private git repositories.


Everything is in Git, if it isn't in Git it does not exist. Further we
are a
[git-flow](http://nvie.com/posts/a-successful-git-branching-model/ )
branching model which means the repository always has both a `master`
and `develop` branch. So to checkout the code you will always have to
checkout both branches.

```
$ git clone git@github.com:Teradata/stacki.git
$ cd stacki
$ git checkout -b develop origin/develop
```

#### Feature Branches

All development should be done on feature branches created by
`git-flow` (or directly in git for the git power users). Once a
feature is ready to be shared with the team and have passed the
nightly build and test system it can be added to the list of branches
to be merged back onto developer during the team's weekly merge
party. Exceptions will happen but the general rule here is always stay
on a feature branch, and merge back only as a group.

To start a feature branch:

```
$ git flow feature start name-of-feature
```

#### Merge Party

Every week (or more frequently) every developer with a completed
feature will sit in a room together and merge their branches back onto
develop, and immediately get develop back into the build and test system.

	*next merge party will document the process*




### Release Process

Releases begin after the desired feature branches are all merged onto
the `develop` branch and have been tested in the nightly build and
test system. The release process begins with a fresh clone on the
stacki repository, and since we are releasing from the `develop`
branch that needs to be checked out as well.

```
$ git clone git@github.com:Teradata/stacki.git
$ cd stacki
$ git checkout -b develop origin/develop
```

Unlike the development process, during we release we require the use
of `git-flow` to start and new release branch and eventually merge
everything back onto `develop` and `master`. *Note* that we accept the
default values for all of `git-flow` except for the `Version tag
prefix` which should be set to `stacki-`.

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

Next decide on the name for the release (e.g. 5.1rc1) and start the
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

Once the release is started only bugfixes are allowed to be checked
into the release branch. Development on feature branches and the
weekly feature merges continue, and have no impact on the release
branch. Bugfixes may be direct commits to the release branch or
cherry-picked commits from other branches.

But first push the branch back to the origin.

```
$ git flow release publish 5.1rc1
```

Once the all bugs are squashed and the code is ready to ship it the
branch is merge back onto both `develop` and `master`, this ensures
any bugfixes applied only to the release branch go back into `develop`
and that `master` only contains released code. Finishing the release
will also create a tag based on the release name (in this example the
tag will be `stacki-5.1rc1`).

```
$ git flow release finish 5.1rc1
$ git push
$ git push --tags
```









