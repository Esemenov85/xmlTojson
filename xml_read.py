import xml.etree.ElementTree as ET
file_path = '/users/esemenov/downloads/list.xml'

root = ET.parse(file_path).getroot()

for child in root:
    child.text

print(child[0][1].text, child[1][1].text, child[2][1].text)

a = child[0].find("title").text
print([a, child[1].find("title").text])

print(*(child.text for child in ET.parse(file_path).getroot()), sep='\n')



for title in root.findall(file_path, 'title'):
    name = title.find(file_path, 'title')
    print(name.text)
    for char in title.findall(file_path, 'title'):
        print(' |-->', char.text)




