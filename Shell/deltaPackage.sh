if [ -d 'PRFiles1' ];
then
    rm -rf PRFiles1
fi

if [ ! -d 'PRFiles1' ];
then
    mkdir PRFiles1
fi
echo PRFiles1/ >> .gitignore

Destination=PRFiles1
IFS=''
while read -r line; do
    temp=$(echo $line | grep "objectTranslations")
    if [ ! -z $temp ];
    then
        flag=1
    else
        flag=0
    fi
    temp=$(echo $line | grep "classes")
    temp1=$(echo $line | grep ".cls-meta.xml")
    if [[ ! -z $temp && -z $temp1 ]];
    then
        flagClasses=1
    else
        flagClasses=0
    fi
    if [ $flagClasses -eq 1 ]; then
        newpath=$(echo $line | sed 's/\/[^/]*$//')
        folder=$(echo $line | awk -F/ '{print $(NF)}')
        newpath=$newpath"/"$folder"-meta.xml"
        cp --parents $newpath $Destination
    fi
    temp=$(echo $line | grep "trigger")
    temp1=$(echo $line | grep ".trigger-meta.xml")
    if [[ ! -z $temp && -z $temp1 ]];
    then
        flagTriggers=1
    else
        flagTriggers=0
    fi
    if [ $flagTriggers -eq 1 ]; then
        newpath=$(echo $line | sed 's/\/[^/]*$//')
        folder=$(echo $line | awk -F/ '{print $(NF)}')
        newpath=$newpath"/"$folder"-meta.xml"
        cp --parents $newpath $Destination
    fi
    #echo $line
    line=$(echo $line | tr -d "\r")
    #echo $line
    cp --parents $line $Destination
done < "files.txt"


echo "Building Package.xml"

sfdx force:source:manifest:create --source-dir "$Destination/force-app/main/default" --output-dir package1/

#rm -rf PRFiles

echo "Finished Package.xml please find the package at $(readlink -f package1/package.xml)"
