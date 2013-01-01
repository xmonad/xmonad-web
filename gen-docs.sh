#!/bin/sh

startdir=`pwd`

mkdir -p xmonad-docs
cd xmonad-docs
destdir=`pwd`

tmp=`mktemp -d`

gendocs () {
    cd $tmp
    if [ -e "$startdir/$1-$2.tar.gz" ]; then cp $startdir/$1-$2* .; tar xf $1-$2*;
            else cabal unpack $1;
    fi
    cd $1*
    if [ -n "$3" ]; then flags="--flags='$3'";
    fi
    runhaskell Setup configure --user $flags
    runhaskell  Setup haddock --hyperlink-source --html-location='http://xmonad.org/xmonad-docs/$pkg'
    cp dist/doc/html/*/*.haddock $destdir
    rsync -a dist/doc/html/ $destdir
}

gendocs xmonad 0.11
gendocs X11
gendocs X11-xft
# gendocs utf8-string
gendocs xmonad-contrib 0.11 "with_xft"

rm -r $tmp

cd $destdir
for name in */; do
    for x in ${name}*.haddock; do
        n=`echo $name | tr -d '/'`
        haddock_args="$haddock_args --read-interface=$n,$x"
    done
done
echo $haddock_args
haddock -t 'Welcome to XMonad' --gen-contents --gen-index -o . --prologue $startdir/prologue.txt $haddock_args
