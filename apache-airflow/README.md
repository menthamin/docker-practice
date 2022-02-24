- 참고자료: https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html
- airflow docker image 빌드
```bash 
docker build . -f Dockerfile --tag airflow-exam:2.2.3
```

-- airflow docker-compose 다운로드
```bash
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.2.3/docker-compose.yaml'
```

- 폴더생성 및 권한 부여
```bash
sudo mkdir -p /opt/airflow/dags \
/opt/airflow/logs \
/opt/airflow/plugins \
/opt/airflow/conf \
/opt/airflow/connector \
/opt/airflow/scripts \
/opt/airflow/sql \
/opt/airflow/sources

sudo chmod -R 775 /opt/airflow

sudo groupadd grp-airflow
sudo gpasswd -a mentha grp-airflow
sudo chown -R :grp-airflow /opt/airflow
```

- airflow webserver 초기 계정/패스워드 설정 필요시 
- docker-compose.yaml 경로에 아래와 같은 .env 파일 생성
```bash
# .env 파일
AIRFLOW_UID=50000
_AIRFLOW_WWW_USER_USERNAME=계정명
_AIRFLOW_WWW_USER_PASSWORD=패스워드
```

- init
```bash
docker-compose up airflow-init
```

- 실행
```bash
sudo docker-compose up -d
```

- 설치 내용 및 디렉토리 설명
```text
설치 인스턴스
airflow-scheduler - The scheduler monitors all tasks and DAGs, then triggers the task instances once their dependencies are complete.
airflow-webserver - The webserver is available at http://localhost:8080.
airflow-worker - The worker that executes the tasks given by the scheduler.
airflow-init - The initialization service.
flower - The flower app for monitoring the environment. It is available at http://localhost:5555.
postgres - The database.
redis - The redis - broker that forwards messages from scheduler to worker.

디렉토리 설명
./dags - you can put your DAG files here.
./logs - contains logs from task execution and scheduler.
./plugins - you can put your custom plugins here.
```

중지 및 이미지 삭제
```
docker-compose down --volumes --rmi all
```