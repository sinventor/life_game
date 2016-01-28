# Игра Жизнь

## Диаграмма сущностей

![uml_class_diagram.png](https://github.com/sinventor/life_game/blob/master/diagrams/uml_class_diagram-2.png)

## Информация об игре
[WIKIPEDIA](https://ru.wikipedia.org/wiki/%D0%96%D0%B8%D0%B7%D0%BD%D1%8C_%28%D0%B8%D0%B3%D1%80%D0%B0%29)

## Как это выглядит?

Данный вариант предназначен для запуска через консоль, примерный вид которой выглядит следующим образом.

<div style="text-align:center" markdown="1">

![main_menu.png](https://github.com/sinventor/life_game/blob/master/images/main_menu.png)

</div>

Пользователь может выбрать скоуп, который ему нужен, соотвтетственно, нажимая клавишу, которая указана в меню.

![games_scope.png](https://github.com/sinventor/life_game/blob/master/images/games_scope.png)

Например, когда пользователь находится в скоупе **games**, он может посмотреть доску, запустить игровой процесс, выбрать новый файл конфигурации (файлы для запуска находятся в папке *file_samples*/ и имеют префикс **configuration_**, после чего номер и расширение *csv*).
![change_config_file.png](https://github.com/sinventor/life_game/blob/master/images/change_config_file.png)
![display_game_configuration.png](https://github.com/sinventor/life_game/blob/master/images/display_game_configuration.png)
![quit_from_current_scope.png](https://github.com/sinventor/life_game/blob/master/images/quit_from_current_scope.png)

Для демонстрации игрового процесса был создан скрипт, записывающий игровой процесс непосредственно в *gif* файл.
Запись в файл производился при помощи джема [RMagick](https://rubygems.org/gems/rmagick/). Далее представлены несколько примеров для различных первоначальных конифгураций.

### Пример для [конфигурации №7](https://github.com/sinventor/life_game/blob/master/file_samples/configuration_7.csv)

![demonstration_7.gif](https://github.com/sinventor/life_game/blob/master/images/demos/demonstration_7.gif)

### Пример для [конфигурации №8](https://github.com/sinventor/life_game/blob/master/file_samples/configuration_8.csv)
![demonstration_8.gif](https://github.com/sinventor/life_game/blob/master/images/demos/demonstration_8.gif)

### Пример для [конфигурации №9](https://github.com/sinventor/life_game/blob/master/file_samples/configuration_9.csv)
![demonstration_9.gif](https://github.com/sinventor/life_game/blob/master/images/demos/demonstration_9.gif)