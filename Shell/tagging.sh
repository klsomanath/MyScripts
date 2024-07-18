filepath='commits2.txt'
i=-1
while read commitId; do
    echo $commitId
    arbitraryvalue="12."$((++i))
    tagname="UAT-CPQ-PI12-V$arbitraryvalue"
    echo $tagname
    echo $(git tag $tagname $commitId)
    echo $(git push origin $tagname)
done < $filepath