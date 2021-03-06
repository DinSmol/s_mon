# Web сервис для мониторинга сети
Сервис мониторит определенный перечень ip-адресов посредством отправки команды ping (ICMP).  
Период опроса - 2 минуты.  
Если в течение 55 секунд нет ответа от сервера, считаем, что сервер недоступен.

## Список ресурсов
- **GET localhost:3323/items/:id** - получение информации по конкретному адресу
- **POST localhost:3323/items** - добавление адреса в БД  
-- параметры:
  - address (IP адрес ipv4)
  - description (текстовое описание)  
- **PUT localhost:3323/items/:id** - изменение параметров адреса (параметр disabled включает/отключает мониторинг)
- **DELETE localhost:3323/items/:id** - удаление адреса из БД
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
      "min": 249.184,  
      "avg": 254.507,  
      "max": 260.687,  
      "median_score": 252.542, (медианное значение)  
      "st_avg": 4.885885044356521, (среднеквадратичное отклонение)    
      "cnt": 4, (кол-во запросов ping, используемых при расчете)   
      "loss": 0 (процент потерянных пакетов)  
    }  
  
## Порядок локального запуска в docker контейнерах
Необходимо последовательно выполнить следующие команды:
- git clone https://github.com/DinSmol/s_mon.git
- cd s_mon
- docker-compose up -d --build

## Особенности
- сервис разработан на основе DSL sinatra;
- сервис запускается на порту 3323;  
- роуты находятся в файле servers_app.rb  
- цикличность опроса IP адресов реализована с помощью cron
- база автоматически заполняется 1000 рандомных IP-адресов (см. миграцию fill_db)

## Что можно было бы улучшить (не сделано в связи с нехваткой времени):
- использовать гипертаблицы для хранения time-series данных, например, timescaledb;
- вынести переменные в env файл;
- добавить тесты;
- часть параметров (интервал опроса, таймауты...) в данной реализации я захардкодил, можно предоставить клиенту возможность изменять интервал опроса в каких-то предопределенных пределах

## Альтернативные решения
- можно также рассмотреть вариант установки zabbix-server и с его помощью получать данные.
