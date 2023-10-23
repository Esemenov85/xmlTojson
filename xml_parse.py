import xml.etree.ElementTree as ET
path = '/users/esemenov/downloads/parsing'
file = 'list.xml'
file_path = ('/users/esemenov/downloads/list.xml')

root = ET.parse(file_path).getroot()

for element in root.findall("passportListXml/standardversion/meta/item/identifier/title"):
    name = element.find("title")
    print(element.tag, name.text, element.attrib)


