#echo > metadata.txt
echo -n $(cat metadata.json | jq -r '.[] | "\""+.directoryName+"\":\""+.xmlName+"\"," ' > metadata.txt) 
cat metadata.txt | tr -d "\n" > metadata1.txt
#XMLNames=$(cat metadata.json | jq -r '.[] | .xmlName ')

#echo $DirName $XMLName

#echo "\"$DirName\"":"\"$XMLName\"" >> metadata.txt
