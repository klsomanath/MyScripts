TargetBranchCommit=134591fbbcbb0f25694964e6c3e85f42d797363f

SourceBranchCommit=$(git log | grep commit | head -1 | awk '{print $2}')

echo $(git diff $TargetBranchCommit $SourceBranchCommit --name-only > PRfiles.txt)

if [ -d 'PRFiles' ];
then
    rm -rf PRFiles
fi

if [ ! -d 'PRFiles' ];
then
    mkdir PRFiles
fi
Destination=C:/Users/lsomanath/Documents/Project/CDW/SITBackMergeCPQQA-0704/CDW-Salesforce-Main/PRFiles
IFS=''
while read -r line; do
    cp --parents $line $Destination
done < "PRFiles.txt"


echo "Building Package.xml"

sfdx force:source:manifest:create --source-dir "$Destination/force-app/main/default" --output-dir package/

rm -rf PRFiles

echo "Finished Package.xml please find the package at $(readlink -f package/package.xml)"
