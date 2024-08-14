story="<Enter Story Number Inside Quotes>"
Branch="<Enter Branch Inside Quotes>"
prnums=$(gh pr list --base $Branch --search $story --state merged --json number,title | jq -r '.[] | .number' | sort -n)
while read -r prnum
do
    echo $prnum
    prnum=$(echo $prnum | cut -c 1-5)
    commits=$(gh pr view $prnum --json commits | jq -r '.commits[] | .oid')
    while IFS= read -r commit
    do
        echo "$commit"
        commit=$(echo $commit | cut -c 1-40)
        git cherry-pick $commit -n --quiet
        if [ $? -eq 0 ]; then
            echo "Cherrypicked the Commit Successfully"
        else
            echo "Dang It!! There are Merge Conflicts"
            echo "Ensure You Resolved all the conflicts and staged the files"
            read -p "Resolved the Conflicts and Staged all the files? (y/N): " opt </dev/tty
            if [[ "$opt" == "y" || "$opt" == "Y" ]]; then
                echo "Proceeding with the operation..."
            else
                exit 1
            fi
            #exit 1
        fi
    done < <(printf '%s\n' "$commits")
done < <(printf '%s\n' "$prnums")