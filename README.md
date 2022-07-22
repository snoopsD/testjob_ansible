# Тестовое задание
Есть сервер с ОС Linux, с системой управления пакетами RPM.
На нём установлена Oracle JDK 1.8 из RPM-пакета.
Необходимо:
1) С помощью Ansible обновить (т.е. удалить старую версию и установить новую) JDK до openjdk-17, взятую с https://openjdk.java.net/projects/jdk/17/ (с прописыванием системных путей к бинарникам в PATH).
2) Установить nginx текущей стабильной версии.
3) Создать файл index.html, в котором содержится IP-адрес сервера, на котором он находится. Для выяснения IP-адреса желательно использовать штатные средства Ansible.
4) Раздать данный файл через nginx.

- Клонируем репозиторий.
- Генерируем ключи сами: ssh-кеygen -f ssh-keys/ansible_key -t rsa
- Создаем файл terraform.tfvars(копируем terraform.tfvars.sample), заполняем секреты от aws аккаунта.
- Запускаем terraform apply. После того, как инфраструктура готова, можно зайти на инстанс и проверить версию java.
- В ansible/hosts прописываем ip адрес инстанса и запускаем playbook update_java_install_nginx.yml
- Когда плейбук отработал, заходим на инстанс и проверяем:
> java -version \
> curl localhost \
> И с локальной машины в браузере вбиваем адрес инстанса, смотрим вывод

