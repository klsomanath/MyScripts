file_read = "files.txt"
m=[]
components=dict()
map_components={"applications":"CustomApplication","aura":"AuraDefnitionBundle","approvalProcesses":"ApprovalProcess","classes":"ApexClass","customMetadata":"CustomMetadata","duplicateRules":"DuplicateRule","flexipages":"FlexiPage","flowDefinitions":"FlowDefinition","flows":"Flow","globalValueSets":"GlobalValueSet","labels":"CustomLabels","layouts":"Layout","lwc":"LigntningComponentBundle","matchingRules":"MatchingRules","omniDataTransforms":"OmniDataTransform","omniScripts":"OmniScript","pages":"ApexPage","permissionsetgroups":"PermissionsetGroup","permissionsets":"PermissionSet","profiles":"Profile","quickActions":"QuickAction","reports":"Report","settings":"Settings","staticresources":"Staticresource","territory2Models":"Territory2Model","triggers":"ApexTrigger","objects":"CustomObject"}
with open(file_read,"r") as f:
    lines=f.readlines()
    prevk=""
    for line in lines:
        l=line.split("/")
        keyk=map_components.get(l[0], l[0])
        if keyk!=prevk:
            values=[]
        values.append(l[1].split(".")[0])
        prevk=keyk
        components[keyk]=list(set(values))
with open("Package.xml","w") as f1:
    f1.write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n')  # XML declaration
    f1.write('<Package xmlns="http://soap.sforce.com/2006/04/metadata">\n')
    f1.write('\t<types>\n')
    for name,members in components.items():
        for i in members:
            out="\t\t<members>"+i+"</members>\n"
            f1.write(out)
        out="\t\t<name>"+name+"</name>\n"
        f1.write(out)
        f1.write('\t</types>\n')
    f1.write("\t<version>60.0</version>\n")
    f1.write("</package>")
        #print(type,type_count)
#print(lines)