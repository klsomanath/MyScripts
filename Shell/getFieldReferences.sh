## Run the below cammand in bash for the SFDX AUthorisation url
## sf org display --target-org devhub --verbose | grep "Sfdx Auth Url" | awk '{print $4}' > auth.txt

#Authorise an Org
alias="myorg"

sf org login sfdx-url --sfdx-url-file auth.txt -a $alias

#Execue the Query

ObjectAPIName="Ride__c"
FieldLabel="Drop"

fieldId=$(sf data query --query "SELECT Id FROM CustomField WHERE EntityDefinition.QualifiedApiName='$ObjectAPIName' and DeveloperName='$FieldLabel' " --use-tooling-api --target-org $alias -r csv | head -2 | tail -1)


fieldId1=$(echo $fieldId | cut -c 1-15)

sf data query --query "SELECT MetadataComponentType, MetadataComponentName, RefMetadataComponentName, RefMetadataComponentId FROM MetadataComponentDependency WHERE RefMetadataComponentId='$fieldId1' AND RefMetadataComponentType='CustomField' ORDER By RefMetadataComponentName" --target-org $alias --use-tooling-api -r 'csv' > "FieldReferences.csv"
