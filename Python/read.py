file_read = "files1.txt"
m=[]
k=0
map_components={"OmniInteractionConfig":"OmniInteractionConfig","applications":"CustomApplication","aura":"AuraDefnitionBundle","approvalProcesses":"ApprovalProcess","classes":"ApexClass","customMetadata":"CustomMetadata","duplicateRules":"DuplicateRule","flexipages":"FlexiPage","flowDefinitions":"FlowDefinition","flows":"Flow","globalValueSets":"GlobalValueSet","labels":"CustomLabels","layouts":"Layout","lwc":"LigntningComponentBundle","matchingRules":"MatchingRules","omniDataTransforms":"OmniDataTransform","omniScripts":"OmniScript","pages":"ApexPage","permissionsetgroups":"PermissionsetGroup","permissionsets":"PermissionSet","profiles":"Profile","quickActions":"QuickAction","reports":"Report","settings":"Settings","staticresources":"Staticresource","territory2Models":"Territory2Model","triggers":"ApexTrigger","objects":"CustomObject","fields":"CustomField","validationRules":"ValidationRule","compactLayouts":"CompactLayout","listViews":"ListView","recordTypes":"RecordType"}
#components=dict.fromkeys(map_components.values(),m)
components = {k: [] for k in map_components.values()}
with open(file_read,"r") as f:
    lines=f.readlines()
    for line in lines:
        print(line)
        l=line.split("/")
        if "objects" in l and len(l)>3:
            j=4
        else:
            j=3
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
            #print(keyk)
            components[keyk].append(l[1].split(".")[0])
            #components[keyk].append(val1)
            #print(l[1].split(".")[0])
        #print(keyk)