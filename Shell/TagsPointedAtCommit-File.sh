#!/bin/bash
fileName="<file Name>"
lastCommit="Commit ID till where you want to check"
git log SIT -- $fileName | grep commit | cut -d " " -f 2 > "File Name to write"

while read -r commit 
do
    if [ "$commit" = "$lastCommit" ];
    then
        echo "Break"
        break
    fi
    tag=$(git tag --points-at $commit | head -n 1 ) 
    #echo $tag
    if [ -z $tag ];
    then
        echo "$commit" >> FileName-Tags.txt
    fi
done < "FileName to read"