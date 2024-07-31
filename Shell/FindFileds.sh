## This will find if the specified field is present in the org or not.

## Run the below cammand in bash for the SFDX AUthorisation url
## sf org display --target-org devhub --verbose | grep "Sfdx Auth Url" | awk '{print $4}' > auth.txt

alias="<determine Org Alias>"

#Authorise the Org

sf org login sfdx-url --sfdx-url-file auth.txt -a $alias

while read -r line; do
    ObjectAPIName=$(echo $line | cut -d "," -f 1)
    FieldLabel=$(echo $line | cut -d "," -f 2)
    fieldId=$(sf data query --query "SELECT Id FROM CustomField WHERE EntityDefinition.QualifiedApiName='$ObjectAPIName' and DeveloperName='$FieldLabel' " --use-tooling-api --target-org $alias -r csv | head -2 | tail -1)
    if [ ! -z $fieldId ];
    then
        echo $ObjectAPIName"."$FieldLabel"__c" >> FoundFields.csv
    fi
done < Fields.txt