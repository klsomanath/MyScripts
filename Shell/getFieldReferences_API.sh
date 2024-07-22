## Run the below cammand in bash for the SFDX AUthorisation url
## sf org display --target-org devhub --verbose | grep "Sfdx Auth Url" | awk '{print $4}' > auth.txt


Domain="<Paste your Domain URL Here>" # It will be like https://comapanyname.sandbox.lighntining.force.com
                                      # Domain Name is companyname.sandbox

alias="<determine Org Alias>"

#Authorise the Org

sf org login sfdx-url --sfdx-url-file auth.txt -a $alias

# Get Token URL
# Run the below Command to get token in a file
# sf org display --target-org $alias --verbose | grep "Access Token" | awk '{print $3}' > token.txt


## Please don't commit the file with github token hardcoded. Else the token will be revoked by github as it is not best practice

## If referring in an YML file use SECRETS for defining the token
token="<Paste your SF Org Token>"

ObjectAPIName="<Object API Name>"

FieldLabel="<Field API Name Excluding __c>"

fieldId=$(sf data query --query "SELECT Id FROM CustomField WHERE EntityDefinition.QualifiedApiName='$ObjectAPIName' and DeveloperName='$FieldLabel' " --use-tooling-api --target-org $alias -r csv | head -2 | tail -1)

fieldId1=$(echo $fieldId | cut -c 1-15)

## Create request.json file to pass the Query

echo "{
        \"operation\": \"query\", 
        \"query\": \"SELECT MetadataComponentType, MetadataComponentName, RefMetadataComponentName, RefMetadataComponentId FROM MetadataComponentDependency WHERE RefMetadataComponentId='$fieldId1' AND RefMetadataComponentType='CustomField' ORDER By RefMetadataComponentName\"
      }" > request.json


id=$(curl -X POST -H "Authorization: Bearer $token" -H "Content-Type: application/json" -d @request.json https://$Domain.my.salesforce.com/services/data/v61.0/tooling/jobs/query/ | grep -o '"id":"[^"]*' | grep -o '[^"]*$')

sleep 20 ## To update the State of Job to "JOB_COMPLETE"
         ## If you get any error please run the script again it will generate
         ## Will be updated in next Release

curl https://$Domain.my.salesforce.com/services/data/v61.0/tooling/jobs/query/$id/results -H "Authorization: Bearer $token" -H "Content-Type: application/json" > "$ObjectAPIName.$FieldLabel-References.csv"