while read -r line
do
    echo $line | cut -c 3- >> files1.txt
done < files.txt