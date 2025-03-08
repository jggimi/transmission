#!/bin/sh
#
# archivers/xz and devel/git must be installed
#
# delete any old tarballs
rm -r /tmp/transmission-4.1.0.dev* 2> /dev/null
# archive main directory
git archive --format=tar --prefix=transmission-4.1.0.dev/ HEAD | tar xf - -C /tmp
# descend recursively and archive each submodule
git submodule --quiet foreach --recursive 'git archive --format=tar --prefix=transmission-4.1.0.dev/$path/ HEAD | tar xf - -C /tmp'
# create the tarball, compress, move to distfiles
cd /tmp
tar cf transmission-4.1.0.dev.tar transmission-4.1.0.dev
/usr/local/bin/xz transmission-4.1.0.dev.tar && doas mv transmission-4.1.0.dev.tar.xz /usr/ports/distfiles
