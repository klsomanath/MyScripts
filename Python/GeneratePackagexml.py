import os

def process_folders(root_folder, output_file):
    with open(output_file, 'w') as outfile:
        outfile.write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n')  # XML declaration
        outfile.write('<Package xmlns="http://soap.sforce.com/2006/04/metadata">\n')
        for root, folders, files in os.walk(root_folder):
            for folder in folders:
                folder_path = os.path.join(root, folder)
                outfile.write('  <types>\n')
                #outfile.write(f'    {folder}</type>\n')
                #outfile.write('  <members>\n')
                for file in os.listdir(folder_path):
                    file1=file.split(".")
                    file1.remove(file1[-1])
                    if(len(file1)>1):
                        file1.remove(file1[-1])
                    file3='.'.join(file1)
                    outfile.write(f'    <members>{file3}</members>\n')
                #outfile.write('  </members>\n')
                outfile.write('    <name>')
                outfile.write(f'{folder}</name>\n')
                outfile.write(f'  </types>\n')
        outfile.write('</package>')  # Close the root element

if __name__ == "__main__":
    root_folder = r'C:\Users\lsomanath\Documents\Project\CDW\CDW_GitHub\CDW-Salesforce-Main\force-app\main\default'  # Replace with the actual path
    output_file = r'C:\Users\lsomanath\Documents\Project\output.xml'  # XML output file
    process_folders(root_folder, output_file)
