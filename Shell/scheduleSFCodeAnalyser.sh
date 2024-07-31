#!/bin/sh
runSfAnalyser () {
    ActualBranch=$(git branch | grep "*" | cut -d " " -f 2)
    git pull origin $ActualBranch
    Branch=$(git branch | grep "*" | cut -d " " -f 2 | cut -d '\' -f2)
    IFS='/'
    read -ra newarr <<< "$Branch"
    folderName=''
    for val in "${newarr[@]}";
    do
        folderName+="$val"
    done
    IFS=''
    echo $folderName
    currentDate=$(date +%d-%m-%y)
    time1=$(date +%H-%M-%S)
    mkdir -p "$HOME/Documents/Project/CDW/CodeAnalyser/$currentDate/$folderName"
    sf scanner run -t force-app/main/default/classes --outfile $HOME/Documents/Project/CDW/CodeAnalyser/$currentDate/$folderName/$time1-ApexResults.csv
    time2=$(date +%H-%M-%S)
    sf scanner run -t force-app/main/default/lwc --outfile $HOME/Documents/Project/CDW/CodeAnalyser/$currentDate/$folderName/$time2-LWCResults.csv
    echo "The Outputs will be in folder- "$HOME/Documents/Project/CDW/CodeAnalyser/$currentDate/$folderName/
}
path="Documents/Project/CDW/SITReleasePI13Sprint2/CDW-Salesforce-Main" #Change the Path before you run the file
cd $HOME/$path
git checkout SIT
runSfAnalyser
git checkout CPQ/develop
runSfAnalyser