with open("Fields.txt","r") as f:
    lines=f.readlines()
with open("FLSPS.txt","w") as f1:
    for line in lines:
        line=line[:len(line)-1]
        f1.write("\t<fieldPermissions>\n\t\t<editable>false</editable>\n\t\t<field>"+line+"</field>\n\t\t<readable>true</readable>\n\t</fieldPermissions>\n")