#!/bin/sh
#
# archivers/xz and devel/git must be installed
#
# delete any old tarballs
rm -r /tmp/transmission-4.1.0-beta.2* 2> /dev/null
# archive main directory
git archive --format=tar --prefix=transmission-4.1.0-beta.2/ HEAD | tar xf - -C /tmp
# descend recursively and archive each submodule
git submodule --quiet foreach --recursive 'git archive --format=tar --prefix=transmission-4.1.0-beta.2/$path/ HEAD | tar xf - -C /tmp'
# create the tarball, compress, move to distfiles
cd /tmp
tar cf transmission-4.1.0-beta.2.tar transmission-4.1.0-beta.2
/usr/local/bin/xz transmission-4.1.0-beta.2.tar && doas mv transmission-4.1.0-beta.2.tar.xz /usr/ports/distfiles
