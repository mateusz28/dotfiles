#!/bin/sh
#


BASE=${1}
THEIRS=${2}
MINE=${3}
MERGED=${4}
MERGED_MOD=${MERGED/'#'/'\#'}
WCPATH=${5}

echo "BASE"  $BASE
echo "THEIRS"  $THEIRS
echo "MINE"  $MINE 
echo "MERGED"  $MERGED
echo "MERGED_MOD"  $MERGED_MOD
echo "WCPATH" $WCPATH 
~/bin/vim/bin/vimdiff $MINE $THEIRS -c ":bo sp $MERGED_MOD" -c ":diffthis" -c "setl stl=MERGED | wincmd W | setl stl=THEIRS | wincmd W | setl stl=MINE"
