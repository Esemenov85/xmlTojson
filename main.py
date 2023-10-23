import xml.etree.ElementTree as ET
import xml.dom.minidom
file_path_m = '/users/esemenov/downloads/list.xml'
file_path_w = 'C:/Users/Evgeniy_S/Downloads/list.xml'

def get_spisok():
    root = ET.parse('list.xml').getroot()   # получаем доступ к xml файлу
    doc = xml.dom.minidom.parse('list.xml');    # используем функцию parse() для загрузки и парсинга XML файла
    print(doc.nodeName) # выводим узел документа и имя первого дочернего тега
    print(doc.firstChild.tagName)
    expertise = doc.getElementsByTagName("title")   # получаем список тегов XML из документа и выводим каждый
    ch = int(expertise.length) - 1  # получаем уол-во тегов для спписка начиная с 0
    for child in root: child.text
    first_n = child[0].findtext("title")
    last_n = child[122].findtext("title")
    print("первое значение:", first_n+'\n'+'последнее значение:', last_n+'\n')
    print("%d title:" % expertise.length)
    i = 0
    while i <= ch:
        print(child[i].findtext("title"))    # применяем индекс для получения элемента
        i += 1

if __name__ == "__main__":
    get_spisok()