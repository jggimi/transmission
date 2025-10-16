#!/bin/sh

# archivers/xz and devel/git must be installed.

DISTNAME=transmission-4.1.0.beta2


# create a temporary directory and subdirectory:
TMPDIR=`mktemp -d` || exit 1
mkdir $TMPDIR/$DISTNAME

# create recursed file list, and archive it:
git ls-files --recurse-submodules | pax -rw $TMPDIR/$DISTNAME

# create tarball
(cd $TMPDIR; tar cf $DISTNAME.tar $DISTNAME)

# compress and move to distfiles:
xz $TMPDIR/$DISTNAME.tar
doas mv $TMPDIR/$DISTNAME.tar.xz /usr/ports/distfiles

# remove temporary directory:
rm -r $TMPDIR
