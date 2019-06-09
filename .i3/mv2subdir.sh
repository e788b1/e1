#!/bin/bash

# workdir="`basename $1`"
workdir="${PWD##*/}"
for f in -* ; do mv -- "$f" "${f// /_}" > /dev/null 2>&1 ; done
for f in *\ * ; do mv "$f" "${f// /_}"  > /dev/null 2>&1 ; done
for f in *\'* ; do mv "$f" "${f//\'/_}" > /dev/null 2>&1 ; done
for f in *\"* ; do mv "$f" "${f//\"/_}" > /dev/null 2>&1 ; done

for dirno in $(seq -f %03g 999)
do
    [[ -z `find . -maxdepth 1 -type f ` ]] && exit
    subdir="$workdir"-"$dirno"
    mkdir -v "$subdir"
    find . -maxdepth 1 -type f | sort | head -100 | xargs mv -t "$subdir"
done



