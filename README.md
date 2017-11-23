# xtoo-overlay
[![License](https://img.shields.io/badge/license-GPLv2-9977bb.svg?style=plastic)](https://github.com/Obsidian-StudiosInc/os-xtoo/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/Obsidian-StudiosInc/os-xtoo/master.svg?colorA=9977bb&style=plastic)](https://travis-ci.org/Obsidian-StudiosInc/os-xtoo)
[![Build Status](https://img.shields.io/shippable/5840e5d8e2ab4d0f0058b4b7/master.svg?colorA=9977bb&style=plastic)](https://app.shippable.com/projects/5840e5d8e2ab4d0f0058b4b7/)

## About
Obsidian-Studios, Inc. funtoo/gentoo overlay (a.k.a wltjr's overlay)

This overlay contains many things that should be in Gentoo but are not. 
A majority of the ebuilds are not in tree. Some are corrections or 
modifications to versions in tree. Others are newer versions 
and/or slot changes.

Ebuilds in this overlay are to be current and latest available versions, 
including working live ebuilds. All ebuilds in this overlay should be 
production quality and many are used in production, though some are 
not. Contributions are welcome!

## Arch
This repo is primarily amd64, no other archs are supported or tested, 
but can be added upon request.

## Credits and Copyright
Original ebuilds in this overlay are Copyright Obsidian-Studios, Inc. 
They can be used else where, but the copyright must be respected and 
preserved. It can be relocated, and/or credit mentioned to original 
source, such as

```shell
# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#
# Original work Copyright 2017 Obsidian-Studios, Inc.
# Ebuild written by "William L. Thomson Jr." <wlt@o-sinc.com>
# <link to ebuild in this repo>
```

## Java
This repository requires Java 9 now.

Work for full support for Java 9 is underway. In addition to fully 
replacing all needed Java packages in Gentoo that have not been 
updated, and/or ingored. Eventually replacing all packages in dev-java 
with superior well maintained current versions.

This is the most comprehensive, current repository of Java ebuilds.

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
managers, desktops and toolkits ever! Upstream is not responsive to 
feedback or any critique. There are numerous bugs, and new versions 
seem to get worse vs better. Things they do not care about; X, multiple 
displays, copy and paste. Those tend to have major issues compared to  
other window managers, desktops, and toolkits.

You have been forewarned! Make sure to file [bugs 
upstream](https://phab.enlightenment.org/). We are unable to due to a 
[permanent ban](https://phab.enlightenment.org/T6222). Horrendously 
rude community! There are a few who are professional and polite. Look at 
the [bugs for ecrire being ignored...](https://github.com/Obsidian-StudiosInc/ecrire/issues)

## Netbeans IDE
Work is underway to package 
[Netbeans](https://github.com/apache/incubator-netbeans) 9 from source. 
THere is no ETA at this time when this will be done, or initial work in 
a usable state. We do use Netbeans as our primary IDE for C and Java.

## Eclipse IDE
There are no plans to package Eclipse IDE from source. We are 
[Netbeaners](https://netbeans.org). That will be added someday but for 
now is maintained fairly well in Gentoo's main repository. Due to being 
dependencies of other applications. Many pieces of Eclipse IDE are 
packaged from source and more are being added. Only as needed as part of 
a dependency chain for other packages.

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
