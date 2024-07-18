import xml.etree.ElementTree as ET

def extract_object_values(xml_file_path):
    tree = ET.parse(xml_file_path)
    root = tree.getroot()

    object_values = []

    # Find all objectPermissions elements
    object_permissions_elements = root.findall('.//{http://soap.sforce.com/2006/04/metadata}objectPermissions')

    for obj_permissions in object_permissions_elements:
        # Find the object element within each objectPermissions element
        object_element = obj_permissions.find('{http://soap.sforce.com/2006/04/metadata}object')
        
        # Check if the object element is found
        if object_element is not None:
            object_values.append(object_element.text)

    return object_values

# Example usage
xml_file_path = 'Query_All_Files.permissionset-meta.xml'
values_between_objects = extract_object_values(xml_file_path)

#print(values_between_objects)
with open ("ObjectsInQueryAllFiles.txt",'w') as f:
    for i in values_between_objects:
        f.write(i)
        f.write('\n')
print(len(values_between_objects))
"""with open("Query_All_Files_csv.txt", 'w') as f:
    f.write("(")
    for i in values_between_objects:
        f.write("\'"+i+"\'")
        f.write(",")
    f.write(")")"""