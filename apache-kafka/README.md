# 도커 환경에서 간단한 카프카 환경 구성하기
<br>

## 개요
도커 환경에서 카프카를 구성하는 다양한 방법 중 컨플루언트(Confluent)에서 제공하는 도커로 구성하기
- 컨플루언트: 아파치 카프카를 최초로 개발한 엔지니어(제이 크렙스, 네하 나크헤데, Jun Rao)가 설립한 회사

컨플루언트에서 제공하는 도커에는 카프카 뿐만 아니라 카프카 외 필요한 애플리케이션들도 모두 포함되어 있음
- 주키퍼, 카프카, 스키마 레지스트리, rest-proxy, 커넥트, ksql-datagen, ksqldb, 컨트롤 센터, ksqldb-cli 등

<br>

## 도커로 카프카 실행하기
docker-compose.yml 다운로드
```bash
curl --silent --output docker-compose.yml https://raw.githubusercontent.com/confluentinc/cp-all-in-one/7.0.1-post/cp-all-in-one/docker-compose.yml
```
실행
```bash
docker-compose up -d
```
실행 결과 확인
```bash
docker-compose ps
>>>
NAME                COMMAND                  SERVICE             STATUS              PORTS
broker              "/etc/confluent/dock…"   broker              running             0.0.0.0:9092->9092/tcp, 0.0.0.0:9101->9101/tcp, :::9092->9092/tcp, :::9101->9101/tcp
connect             "/etc/confluent/dock…"   connect             running             0.0.0.0:8083->8083/tcp, :::8083->8083/tcp
control-center      "/etc/confluent/dock…"   control-center      running             0.0.0.0:9021->9021/tcp, :::9021->9021/tcp
ksql-datagen        "bash -c 'echo Waiti…"   ksql-datagen        running             
ksqldb-cli          "/bin/sh"                ksqldb-cli          running             
ksqldb-server       "/etc/confluent/dock…"   ksqldb-server       running             0.0.0.0:8088->8088/tcp, :::8088->8088/tcp
rest-proxy          "/etc/confluent/dock…"   rest-proxy          running             0.0.0.0:8082->8082/tcp, :::8082->8082/tcp
schema-registry     "/etc/confluent/dock…"   schema-registry     running             0.0.0.0:8081->8081/tcp, :::8081->8081/tcp
zookeeper           "/etc/confluent/dock…"   zookeeper           running             0.0.0.0:2181->2181/tcp, :::2181->2181/tcp

```
개별 컨테이너 관리하기
```bash
docker-compose restart control-center 
```

<br>

## 카프카 동작 실습 (토픽 생성, 프로듀서, 컨슈머)
카프카 3.1 버전 다운로드 및 압축해제 
```bash
wget https://dlcdn.apache.org/kafka/3.1.0/kafka_2.12-3.1.0.tgz
tar zxf kafka_2.12-3.1.0.tgz
```
토픽 생성
```bash
kafka_2.12-3.1.0/bin/kafka-topics.sh --bootstrap-server localhost:9092 --topic peter-test01 --partitions 1 --replication-factor 1 --create
>>>
Created topic peter-test01.
```
콘솔 컨슈머 실행
```bash
kafka_2.12-3.1.0/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic peter-test01
```
새로운 터미널창 오픈 후 콘솔 프로듀서를 사용하여 hello! kafaka! 메시지 전송
```bash
kafka_2.12-3.1.0/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic peter-test01
```
컨트롤 센터 접근해보기
-  http://localhost:9021/clusters

<br>

## 도커 환경 중지 및 삭제
컨테이너 중지
```bash
docker-compose stop
```
사용하지 않는 도커 이미지 삭제하기
```bash
docker system prune -a --volumes --filter "label=io.confluent.docker"
 ```






- 참고자료: https://devocean.sk.com/blog/techBoardDetail.do?ID=163709&fbclid=IwAR1LASRGVcbZjScDD7jSKCpadyQS1c9sP4PGrPHO3a1UnbOiCbJXYRnsDKM