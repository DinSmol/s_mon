# Web сервис для мониторинга сети
Сервис мониторит определенный перечень ip-адресов посредством отправки команды ping (ICMP).  
Период опроса - 2 минуты.  
Если в течение 55 секунд нет ответа от сервера, считаем, что сервер недоступен.

## Список ресурсов
- **GET localhost:3323/addresses/:address** - получение информации по конкретному адресу
- **POST localhost:3323/addresses** - добавление адреса в БД  
-- параметры:
  - address (IP адрес ipv4)
  - description (текстовое описание)  
- **PUT localhost:3323/addresses** - изменение параметров адреса (параметр disabled включает/отключает мониторинг)
- **DELETE localhost:3323/addresses/:address** - удаление адреса из БД
  <br></br>
- **GET localhost:3323/stat?address=127.0.0.1** - получение статистической информации по конкретному адресу  
-- параметры:
  - address (IP адрес ipv4)
  - from (начало интервала, datetime, значение по умолчанию: -1 час от текущего времени)
  - to (окончание интервала, datetime, значение по умолчанию: текущее время)  
*пример запроса*  
localhost:3323/stat?address=127.0.0.1&from=2021-03-23 18:00:00&to=2021-03-23 21:00:00  
*ответ на запрос возвращается в формате json*  
    {  
    "min": 284.136, 
    "avg": 287.70770000000005,  
    "max": 297.63,  
    "st_avg": 2.715952746402195, (среднеквадратичное отклонение)  
    "cnt": 30, (кол-во запросов ping, используемых при расчете)  
    "loss": 0 (процент потерь)  
    }
  
## Порядок локального запуска в docker контейнерах
Необходимо последовательно выполнить следующие команды:
- git clone https://github.com/DinSmol/s_mon.git
- cd s_mon
- docker-compose up -d --build

## Особенности
- сервис разработан на основе DSL sinatra;
- сервис запускается на порту 3323;
- цикличность опроса IP адресов реализована с помощью cron

## Что можно было бы улучшить (не сделано в связи с нехваткой времени):
- использовать гипертаблицы для хранения time-series данных, например, timescaledb;
- вынести переменные в env файл;
- добавить тесты;
- часть параметров (интервал опроса, таймауты...) в данной реализации я захардкодил, можно предоставить клиенту возможность изменять интервал опроса в каких-то предопределенных пределах

## Альтернативные решения
- можно также рассмотреть вариант установки zabbix-server и с его помощью получать данные.
