psql -c " CREATE DATABASE zabbix WITH ENCODING='UTF-8';"
psql -c " CREATE USER zabbix WITH PASSWORD '{{ DBPassword }}';"
psql -c " GRANT ALL ON DATABASE zabbix TO zabbix;"
psql -c " GRANT ALL PRIVILEGES ON DATABASE zabbix to postgres;"
