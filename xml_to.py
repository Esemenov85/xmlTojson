import json
import xml.etree.ElementTree as ET
file_path = '/users/esemenov/downloads/list.xml'

def xml_to_dict(element):
    result = {}
    for child in element:
        if len(child) & gt; 0:
            value = xml_to_dict(child)
        else:
            value = child.text

        key = child.tag
        if key in result:
            if not isinstance(result[key], list):
                result[key] = [result[key]]
            result[key].append(value)
        else:
            result[key] = value

    return result

# root = ET.parse(file_path).getroot()

# Парсинг XML
root = ET.fromstring(file_path)

# Преобразование XML в словарь
dict_data = xml_to_dict(root)

# Преобразование словаря в JSON
json_data = json.dumps(dict_data)

print(json_data)