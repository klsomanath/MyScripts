story=269629
Branch=PSAdevelop
prnums=$(gh pr list --base $Branch --search $story --state merged --json number,title  jq -r '.[]  .number'  sort -n)
while read -r prnum
do
    echo $prnum
    prnum=$(echo $prnum  tr -d 'r')
    commits=$(gh pr view $prnum --json commits  jq -r '.commits[]  .oid')
    while IFS= read -r commit
    do
        echo $commit
        commit=$(echo $commit  tr -d 'r')
        git cherry-pick $commit -n
        if [ $ -eq 0 ]; then
            echo Cherrypicked the Commit Successfully
        else
            echo Dang It!! There are Merge Conflicts
            echo Ensure You Resolved all the conflicts and staged the files
            read -p Resolved the Conflicts and Staged all the files (yN)  opt devtty
            if [[ $opt == y  $opt == Y ]]; then
                echo Proceeding with the operation...
            else
                exit 1
            fi
            #exit 1
        fi
    done  (printf '%sn' $commits)
done  (printf '%sn' $prnums)