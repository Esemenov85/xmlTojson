import xml.etree.ElementTree as ET
import xml.dom.minidom
file_path_m = '/users/esemenov/downloads/list.xml'
file_path_w = 'C:/Users/Evgeniy_S/Downloads/list.xml'

root = ET.parse('list.xml').getroot()

# используем функцию parse() для загрузки и парсинга XML файла
doc = xml.dom.minidom.parse('list.xml');
# выводим узел документа и имя первого дочернего тега
print(doc.nodeName)
print(doc.firstChild.tagName)
# получаем список тегов XML из документа и выводим каждый
expertise = doc.getElementsByTagName("title")
ch = int(expertise.length) - 1


for child in root:
    child.text

first_n = child[0].findtext("title")
last_n = child[122].findtext("title")
print("первое значение:", first_n+'\n'+'последнее значение:', last_n+'\n')

print("%d title:" % expertise.length)

n =+ 1
i = 0
while i <= ch:
    print(child[i].findtext("title"))    # применяем индекс для получения элемента
    i += 1
