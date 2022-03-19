참고자료: https://www.notion.so/Scheduler-HA-Public-8faed2642bc849158052ba9f0e1a2c39
참고자료: https://www.youtube.com/watch?v=W1vMCB40NjY
# docker run
astro d start

# docker ps check
astro d ps
```bash
Name                            State           Ports
airflow2603fd4_scheduler_1      Up 3 minutes
airflow2603fd4_webserver_1      Up 3 minutes    0.0.0.0:8080->8080/tcp, :::8080->8080/tcp
airflow2603fd4_scheduler-2_1    Up 3 minutes
airflow2603fd4_postgres_1       Up 3 minutes    0.0.0.0:5432->5432/tcp, :::5432->5432/tcp
```

# docker kill
docker kill airflow2603fd4_scheduler_1
```bash
Name                            State                           Ports
airflow2603fd4_scheduler-2_1    Up 3 minutes
airflow2603fd4_postgres_1       Up 3 minutes                    0.0.0.0:5432->5432/tcp, :::5432->5432/tcp
airflow2603fd4_scheduler_1      Exited (137) 2 seconds ago
airflow2603fd4_webserver_1      Up 3 minutes                    0.0.0.0:8080->8080/tcp, :::8080->8080/tcp
```