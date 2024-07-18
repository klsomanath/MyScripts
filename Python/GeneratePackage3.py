file_read = "files.txt"
m=[]
k=0
map_components={"OmniInteractionConfig":"OmniInteractionConfig","applications":"CustomApplication","aura":"AuraDefnitionBundle","approvalProcesses":"ApprovalProcess","classes":"ApexClass","customMetadata":"CustomMetadata","duplicateRules":"DuplicateRule","flexipages":"FlexiPage","flowDefinitions":"FlowDefinition","flows":"Flow","globalValueSets":"GlobalValueSet","labels":"CustomLabels","layouts":"Layout","lwc":"LigntningComponentBundle","matchingRules":"MatchingRules","omniDataTransforms":"OmniDataTransform","omniScripts":"OmniScript","pages":"ApexPage","permissionsetgroups":"PermissionsetGroup","permissionsets":"PermissionSet","profiles":"Profile","quickActions":"QuickAction","reports":"Report","settings":"Settings","staticresources":"Staticresource","territory2Models":"Territory2Model","triggers":"ApexTrigger","objects":"CustomObject","fields":"CustomField","validationRules":"ValidationRule","compactLayouts":"CompactLayout","listViews":"ListView","recordTypes":"RecordType"}
#components=dict.fromkeys(map_components.values(),m)
components = {k: [] for k in map_components.values()}
with open(file_read,"r") as f:
    lines=f.readlines()
    for line in lines:
        l=line.split("/")
        if "objects" in l and len(l)>3:
            j=2
        else:
            j=0
        keyk=map_components.get(l[j], l[j])
        if(j==2):
            val=l[1].split(".")
            val1='.'.join(val[3:len(val)-2])
            #print(val1)
            #components[keyk].append(l[1].split(".")[0])
            components[keyk].append(l[1]+"."+l[3].split(".")[0])
            #print(l[1]+"."+l[3].split(".")[0])
        else:
            val=l[1].split(".")
            val1='.'.join(val[:len(val)-1])
            #print(val1)
            components[keyk].append(l[1].split(".")[0])
            #components[keyk].append(val1)
            #print(l[1].split(".")[0])
        #print(keyk)
with open("Package2.xml","w") as f1:
    f1.write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n')  # XML declaration
    f1.write('<Package xmlns="http://soap.sforce.com/2006/04/metadata">\n')
    for name,members in components.items():
        f1.write('\t<types>\n')
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