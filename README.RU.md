
# Об установщике

Это автоматический установщик Octoprint для:
* Плат под управлением дистрибутива Armbian, базирующегося на Debian Buster или Ubuntu Bionic

# Как установить?

## Установка Armbian на вашу плату

1. Скачиваем образ Armbian для своей платы по ссылке https://www.armbian.com/download/
1. Записываем образ на microsd карту: https://www.youtube.com/watch?v=JimDZPXzFds
1. Загружаемся и заходим под пользователем root. Пароль 1234
1. Запускаем armbian-config и настраиваем WiFi

## Запуск установщика Octoprint

Вводим команды поочередно. Каждая строка - отдельная команда
```shell
su -
wget https://raw.githubusercontent.com/Nebari-xx/octoprint_installer/master/octoprint_install.sh
chmod +x octoprint_install.sh
./octoprint_install.sh
```

Скрипт попросит ввести пароль для пользователя octo. Придумываем пароль, вводим и ждем окончания установки.
Теперь можно настраивать Octoprint -  http://<IP_вашей_платы>:5000

Готово!

# Команды для работы с Octoprint

## Вывод логов Octoprint

```shell
journalctl --no-pager -b -u octoprint
```

## Вывод логов стримера с Web камеры

```shell
journalctl --no-pager -b -u octoprint
```

## Перезапуск octoprint

```shell
sudo systemctl restart octoprint.service
```

### Перезапуск стримера Web камеры

```shell
systemctl restart webcam.service
```
