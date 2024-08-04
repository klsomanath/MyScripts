while read -r commit 
do
    tag=$(git tag --points-at $commit) 
    #echo $tag
    if [ ! -z "$tag" ];
    then
        echo $tag - $commit
    else
        echo "Tag Not Found for " $commit
    fi
done < "file to read"