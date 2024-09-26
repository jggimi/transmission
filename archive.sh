#!/bin/sh
#
# archivers/xz and devel/git must be installed
#
# delete any old tarballs
rm -r /tmp/transmission-4.0.x* 2> /dev/null
# archive main directory
git archive --format=tar --prefix=transmission-4.0.x/ HEAD | tar xf - -C /tmp
# descend recursively and archive each submodule
git submodule --quiet foreach --recursive 'git archive --format=tar --prefix=transmission-4.0.x/$path/ HEAD | tar xf - -C /tmp'
# create the tarball, compress, move to distfiles
cd /tmp
tar cf transmission-4.0.x.tar transmission-4.0.x
/usr/local/bin/xz transmission-4.0.x.tar && doas mv transmission-4.0.x.tar.xz /usr/ports/distfiles
