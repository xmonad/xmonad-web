#!/bin/sh -eu

release="0.13"
startdir=`pwd`

mkdir -p xmonad-docs
cd xmonad-docs
destdir=`pwd`

tmp=`mktemp -d`

cleanup () {
  rm -rf $tmp
}

trap "cleanup" EXIT

gendocs () {
    cd $tmp

    name=$1
    flags=""
    ver=""

    if [ $# -gt 1 ]; then
      ver=$2
    fi

    if [ $# -gt 2 ]; then
      flags="--flags='$3'";
    fi

    if [ -e "$startdir/$name-$ver.tar.gz" ]; then
      cp $startdir/$name-$ver* .; tar xf $name-$ver*;
    else
      cabal unpack $name;
    fi

    cd $name*

    cabal sandbox init
    cabal install --only-dependencies
    cabal configure $flags
    cabal haddock --hyperlink-source --html-location='http://xmonad.org/xmonad-docs/$pkg'

    cp dist/doc/html/*/*.haddock $destdir
    rsync -a dist/doc/html/ $destdir
}

gendocs xmonad $release
gendocs X11
gendocs X11-xft
gendocs xmonad-contrib $release "with_xft"

cd $destdir
haddock_args=""

for name in */; do
    for x in ${name}*.haddock; do
        n=`echo $name | tr -d '/'`
        haddock_args="$haddock_args --read-interface=$n,$x"
    done
done

echo $haddock_args
haddock -t 'Welcome to XMonad' --gen-contents --gen-index -o . --prologue $startdir/prologue.txt $haddock_args
