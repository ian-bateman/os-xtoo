# xtoo-overlay
[![License](https://img.shields.io/badge/license-GPLv2-9977bb.svg?style=plastic)](https://github.com/Obsidian-StudiosInc/os-xtoo/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/Obsidian-StudiosInc/os-xtoo/master.svg?colorA=9977bb&style=plastic)](https://travis-ci.org/Obsidian-StudiosInc/os-xtoo)
[![Build Status](https://img.shields.io/shippable/5840e5d8e2ab4d0f0058b4b7/master.svg?colorA=9977bb&style=plastic)](https://app.shippable.com/projects/5840e5d8e2ab4d0f0058b4b7/)

Obsidian-Studios, Inc. funtoo/gentoo overlay (a.k.a wltjr's overlay)
Making Gentoo Java Great Again!

Things that could and should be in Gentoo but are not.

Go GENTOO! :-1:

## About
This overlay mostly contains Java related ebuilds. Most of the 
ebuilds are not in tree, but some are corrections, newer versions 
and/or slot changes. Initial support for Java 9, JDK only at this time. 

Effort will be made to keep packages in this overlay up to date. All 
ebuilds in this overlay should be production quality and many are used 
in production, though some are not. Contributions are welcome!

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

## E
This repo has initial support for 
[Enlightenment](https://www.enlightenment.org/) desktop. This is 
presently the official desktop being used by Obsidian-Studios, Inc. The 
ebuilds in this repository are not perfect. They should be some of the
better quality ones around. Despite being an initial work in progress.

If you have any issues with E packages in this repository. Let us know 
and we will address them ASAP.

There are some known issues. Many EFL/ELM based applications do not 
build nor work with EFL 1.19. That requires live versions. Most anything 
released requires 1.18.4. With the exception of Enlightenment desktop itself, 
terminology, and some other applications. Python EFL libraries do not 
work with 1.19, nor any EFL/ELM application written in Python. EDI is 
also broken on 1.19. All fixed in git, thus live versions for 1.19. 
Which might as well run that live as well.

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
