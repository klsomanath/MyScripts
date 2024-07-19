TargetBranchCommit=<Paste the Target Branch HEAD Commit Here>

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
Destination=<Paste the Destination path Here>PRFiles
IFS=''
while read -r line; do
    cp --parents $line $Destination
done < "PRFiles.txt"


echo "Building Package.xml"

sfdx force:source:manifest:create --source-dir "$Destination/force-app/main/default" --output-dir package/

rm -rf PRFiles

echo "Finished Package.xml please find the package at $(readlink -f package/package.xml)"
