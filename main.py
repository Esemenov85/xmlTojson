import xml.dom.minidom
file_path = '/users/esemenov/downloads/list.xml'
#
# def main():
#     # используем функцию parse() для загрузки и парсинга XML файла
#     doc = xml.dom.minidom.parse('/users/esemenov/downloads/list.xml');
#
#     # выводим узел документа и имя первого дочернего тега
#     print
#     doc.nodeName
#     print
#     doc.firstChild.tagName
#
#     # получаем список тегов XML из документа и выводим каждый
#     expertise = doc.getElementsByTagName("expertise")
#     print
#     "%d expertise:" % expertise.length
#     for skill in expertise:
#         print
#         skill.getAttribute("name")
#
#     # создаем новый тег XML и вставляем его в документ
#     newexpertise = doc.createElement("expertise")
#     newexpertise.setAttribute("name", "BigData")
#     doc.firstChild.appendChild(newexpertise)
#     print
#     " "
#
#     expertise = doc.getElementsByTagName("expertise")
#     print
#     "%d expertise:" % expertise.length
#     for skill in expertise:
#         print
#         skill.getAttribute("name")
#
#
# if name == "__main__":
#     main();

# используем функцию parse() для загрузки и парсинга XML файла
doc = xml.dom.minidom.parse(file_path);

# выводим узел документа и имя первого дочернего тега
print(doc.nodeName)
print(doc.firstChild.tagName)
print(doc.attributes)
# получаем список тегов XML из документа и выводим каждый
expertise = doc.getElementsByTagName("title")
print("%d title:" % expertise.length)
for skill in expertise:
    print(skill.getAttribute(">"))