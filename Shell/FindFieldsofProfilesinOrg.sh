echo "ObjectAPI,FieldAPI" > "ObjectFieldsinProfile.csv"
cat "force-app/main/default/profiles/Admin.profile-meta.xml" | grep "<field>" | tr -d " " | cut -d ">" -f 2 | cut -d "<" -f 1 | sed 's/\./,/' >> "ObjectFieldsinProfile.csv"

alias="CDW-CPQQA"

IFS=","

cat "ObjectFieldsinProfile.csv" | while read ObjectAPIName FieldLabel; do 
FieldLabel=${FieldLabel::-3}

fieldId=$(sf data query --query "SELECT Id FROM CustomField WHERE EntityDefinition.QualifiedApiName='$ObjectAPIName' and DeveloperName='$FieldLabel' " --use-tooling-api --target-org $alias -r csv | head -2 | tail -1)
echo $fieldId

if [ ! -z $fieldId ];
then
    echo $ObjectAPIName"."$FieldLabel"__c" Found in Org
else
    echo $ObjectAPIName"."$FieldLabel"__c" is not in Org
fi

done