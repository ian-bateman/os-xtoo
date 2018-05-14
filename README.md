# xtoo-overlay
[![License](https://img.shields.io/badge/license-GPLv2-9977bb.svg?style=plastic)](https://github.com/Obsidian-StudiosInc/os-xtoo/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/Obsidian-StudiosInc/os-xtoo/master.svg?colorA=9977bb&style=plastic)](https://travis-ci.org/Obsidian-StudiosInc/os-xtoo)
[![Build Status](https://img.shields.io/shippable/5840e5d8e2ab4d0f0058b4b7/master.svg?colorA=9977bb&style=plastic)](https://app.shippable.com/projects/5840e5d8e2ab4d0f0058b4b7/)

## About
Obsidian-Studios, Inc. funtoo/gentoo overlay (a.k.a wltjr's overlay)

This overlay contains many things that should be in Gentoo but are not. 
A majority of the ebuilds are not in Gentoo's respository. Some are 
corrections or modifications to versions in tree. Others are newer versions 
and/or slot changes. This overlay replaces some entire categories like 
dev-java/*. In addition to all Enlightment/EFL applications.

Ebuilds in this overlay are to be current and latest available versions, 
including working live ebuilds. All ebuilds in this overlay should be 
production quality and many are used in production, though some are 
not. Contributions are welcome, but for the present time will only be 
accepted on a limited basis.

This is the most comprehensive Java and Enlightenment repository!

## Warning
Please read subsequent sections before usage. You may need to force pull 
from this overlay at times. That will be kept to a minimum and at some 
point stop entirely. But does happen from time to time.

Please file issues for any problems encounterd. They will be addressed ASAP!

## Arch
This repo is primarily amd64, no other archs are supported or tested, 
but can be added upon request.

## Credits and Copyright
Original ebuilds in this overlay are Copyright Obsidian-Studios, Inc. 
They can be used else where, but the copyright must be respected and 
preserved. It can be relocated, and/or credit mentioned to original 
source, such as

```shell
# Copyright 1999-2018 Some Other Entity
# Distributed under the terms of the GNU General Public License v2
#
# Original work Copyright 2018 Obsidian-Studios, Inc.
# Ebuild written by "William L. Thomson Jr." <wlt@o-sinc.com>
# <link to ebuild in this repo>
```

## Java
This is the most comprehensive Java ebuild repository!

Java packages in this respository are all or nothing. You MUST run 
"@world" update when first adding this overlay. Failure to do such will 
result in various preventable build issues. Please keep that in mind.

This repository replaces entirely dev-java/*::gentoo, packages in 
Gentoo's main repository. The core java-config has been replaced with 
[jem](https://github.com/Obsidian-StudiosInc/jem). Along with updating 
eclasses in preparation for new eclasses, entire re-writes.

We have added a [package to mask 
dev-java/*::gentoo](https://github.com/Obsidian-StudiosInc/os-xtoo/tree/master/app-portage/mask-gentoo-dev-java) 
. Since [masking via overlay](https://bugs.gentoo.org/show_bug.cgi?id=641020) 
is not possible at this time. It is recommended to merge that package 
and unmask any remaining pieces as needed/required, outside of dev-java/.

Please do not mix Java packages from Gentoo's main repository with 
this repository. You will experience a varity of issues that will not be 
addressed! This repository replaces entirely Java on Gentoo!!!

### Java 10+
This repository requires Java 10 as your system vm now, and in fall will 
require Java 11! We are no longer supporting any JDK < 10. Most things 
have been fixed for Java 11. There are few packages remaining that need 
to be fixed or dialed in for Java 11. We recommend Java 10 for 
production and Java 11 for development.

Please report issues for any package that does not build or has 
runtime issues with Java 10 or 11.

### Java Versioning
This overlay implements a brand new feature of no longer requiring Java 
versions in ebuilds. Java verions will be based on the version of Java 
used during build time of any given package. This elimites the need to 
update versions in ebuilds for newer versions of Java. This also 
provides means to have all jars built for a specific Java release. 
Rather than a mixed system with some jars for 6, 7, 8, 9, 10, 11, etc. 

If needed this can be overriden globally for all packages in make.conf, or
[java-util-2.eclass](https://github.com/Obsidian-StudiosInc/os-xtoo/blob/master/eclass/java-utils-2.eclass#L70), 
by setting ```JAVA_RELEASE``` to some value. Or adding that to any 
ebuild individually as needed. Which is the main intended use. The 
global usage is a backup for issues encountered with the new system.
Or to enforce a specific Java release/version across all jars.

This does make building a forward operation. Keep your system/build vm 
set to an older version like 10, if running newer like 11+. If you build 
under 11, and try to run under 10 without the above you will have issues.
Otherwise moving forward should not require rebuild unless package has 
runtime issues. Once you do, you will need to rebuild again if you 
revert back to 10 from 11. Unless you set ```RELEASE="10"``` when 
building under 11+.

Rebuild all installed from dev-java/*
```emerge -qv1O $(qlist -IC 'dev-java/*')```

Show packages built with a given vm, add ```| wc-l``` for count
```grep -l "MERGE_VM\=.*[4-9]" /usr/share/*/package.env```

### Setting system/user VM
This overlay has switched to 
[jem](https://github.com/Obsidian-StudiosInc/jem) from 
[java-config](https://github.com/gentoo/java-config). jem is a drop in 
replacement for java-config, and has the same  syntax and features. jem 
is used in eclasses in this overlay. This overlay does not use 
java-config at all, or any related packages.

## E
This repo has full and complete support for 
[Enlightenment](https://www.enlightenment.org/) desktop. This is 
presently the official desktop being used by Obsidian-Studios, Inc. The 
ebuilds in this repository are not perfect. They should be some of if 
not the best quality ones around.

We develop and maintain a few E applications:
* [Ecrire](https://github.com/Obsidian-StudiosInc/ecrire) - General Text Editor
* [Entrance](https://github.com/Obsidian-StudiosInc/entrance) - Login/Display Manager
* [clipboard](https://github.com/Obsidian-StudiosInc/clipboard) - Clipboard module
* [Eminence](https://github.com/Obsidian-StudiosInc/eminence) - dark purple theme for E

If you have any issues with E packages in this repository. Let us know 
and we will address them ASAP. We take E seriously!

Enlightenment and EFL is likely one of the most buggy window 
managers, desktops and toolkits ever! Upstream is not very responsive to 
feedback or any critique. There are numerous bugs, and new versions 
seem to get worse vs better. Things they do not care about; X, multiple 
displays, copy and paste. Those tend to have major issues compared to  
other window managers, desktops, and toolkits.

You have been forewarned! Make sure to file 
[bugs upstream](https://phab.enlightenment.org/).

It is recommended to not mix EFL/Enlightenment packages in tree with 
this overlay. Those types of issues will likley not be addressed. Any 
issue with an ebuild relating to EFL or Enlightenment within this 
repository will be addressed ASAP.

## Netbeans IDE
Work is underway to package 
[Netbeans](https://github.com/apache/incubator-netbeans) 9 from source. 
Netbeans is presently in a initial usable state. Working on addressing 
Java 10/11 specific isssues. Which Java 10/11 fixes may come from upstream 
and/or go to upstream, or maybe come from YOU! Those are welcome and are 
general issues not related to ebuilds or how Netbeans is packaged in 
this overlay. Just general Netbeans 9 porting issues.

There is no ETA at this time when this work will be completed. We do 
use Netbeans as our primary IDE for C and Java. Presently using Netbeans 
9 snapshot builds under JDK 11. Till Oracle releases the rest of the 
modules we need for packaging from source.

See [Netbeans Apache Transition 
page](https://cwiki.apache.org/confluence/display/NETBEANS/Apache+Transition) 
for details on Oracle's code donations.

Presently we are working on a single master Netbeans ebuild. Which will 
later have function moved to eclass. Along with USE flags added to reduce 
dependencies based on wanted features. Eclass function will allow 
packages to install and register themselves. Presently done via symlinks 
in main 
[dev-util/netbeans](https://github.com/Obsidian-StudiosInc/os-xtoo/tree/master/dev-util/netbeans) 
ebuild. Which will becoming mostly a meta ebuild with just depenencies 
and USE flags.

## Eclipse IDE
There are no plans to package Eclipse IDE from source. We are 
[Netbeaners](https://netbeans.org). Due to being dependencies of other 
applications. Many pieces of Eclipse IDE are packaged from source. Only 
as needed as part of a dependency chain for other packages.

Contributions are welcome to complete the pieces into a usable Eclipse 
IDE from source. This will require additional work. Jars are missing 
various resources, icons, etc. That will be added in a secondary round, 
as mentioned in a subsequent section. Otherwise this will likely never 
happen in this repository.

## Issues
Feel free to open any issues with any package in this repository, 
problems, version bumps, etc. They will be address ASAP as this is an 
actively maintained repository.

## Layman
You can add this overlay to layman as an external git repo.
```
/etc/portage/repos.conf/os-xtoo.conf

[os-xtoo]
location = /usr/local/overlay/os-xtoo
sync-type = git
sync-uri = https://github.com/Obsidian-StudiosInc/os-xtoo.git
auto-sync = yes
```

## Process

Ebuilds in this overlay are a constant work in progress. They are added 
via the following process.

1. Ensure it builds and merges
  1. Ensure dependencies can build and merge against package
2. Ensure it runs and is usable, add missing files, set version, etc
3. Dial in package to meet upstream package

All ebuilds in this overlay meet at least step 1, and 1a. Step 2 is 
done when the package is used directly as a library in a project and/or 
via an existing application that uses it directly. Step 3 is a 
finalization step.

## Profiles
This repository features a few different profiles that are not based on 
any profile in Gentoo's main repository. They are stand alone profiles.

## Stability
Packages in this repository may never be marked stable. This is not 
meant to say some are not stable. Stability on such a platform can 
be considered a misnomer at times. Other things are to fast moving to 
be considered stable and would lag versions from upstream.

Most, not all, Java ebuilds within this repository are presently in use 
both in development and production. The rest have been used at some 
point thus in this repository. Everything should be usable, and as 
stable as provided by upstream.

## Systemd
We run [openrc](https://github.com/OpenRC/openrc) not 
[systemd](https://www.freedesktop.org/wiki/Software/systemd/). 
Systemd users may experience new issues with packages in this overlay, 
specifically 
[efl](https://github.com/Obsidian-StudiosInc/os-xtoo/tree/master/dev-libs/efl), 
[englightenment](https://github.com/Obsidian-StudiosInc/os-xtoo/tree/master/x11-wm/enlightenment) 
and/or 
[tomcat](https://github.com/Obsidian-StudiosInc/os-xtoo/tree/master/www-servers/tomcat). 
All untested under systemd. Not to likely to have problems with other  
packages but it is possible.
 
Please report any issues when running under systemd. Also ideally be 
willing and available to test any fixes, as we cannot without setting 
up a Gentoo test env running systemd. Thank you for your understanding 
and cooperation.
