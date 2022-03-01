# 도커로 오라클 19c 실행하기
- 버전: 19.3 - Enterprise Edition (also includes Standard Edition 2) 

## 설치 과정
### 1. Oracle 소프트웨어 다운로드 (공식홈페이지)
- 링크: https://www.oracle.com/kr/database/technologies/oracle-database-software-downloads.html
- Linux x86-64버전 다운로드, 파일명: LINUX.X64_193000_db_home.zip
<br>

### 2. 오라클 도커이미지 실행 스크립트 다운로드(git clone) 및 소프트웨어 복사
```bash
 git clone https://github.com/oracle/docker-images.git
 mv LINUX.X64_193000_db_home.zip ~/docker-imgaes/Oracledatabse/singleInstance/dockerfiles/19.3.0
```
<br>

### 3. 이미지 빌드
```bash
cd ~/docker-images/OracleDatabase/SingleInstance/dockerfiles
sudo ./buildContainerImage.sh -e -v 19.3.0
```
<br>

### 4. Oracle 데이터 저장용 디렉토리 생성 및 권한 변경 (Docker Volume)
```bash
sudo mkdir /opt/oracle
sudo chmod 777 /opt/oracle

bulid 이미지 확인
docker images
>>
REPOSITORY                         TAG               IMAGE ID       CREATED         SIZE
oracle/database                    19.3.0-ee         3afbbf0c8296   7 hours ago     6.53GB
```
<br>

### 5. Oracle 19c 실행
```bash
docker run --name oracle-19 -p 1521:1521 -p 5500:5500 -e ORACLE_PWD=oracle -v /opt/oracle:/opt/oracle/oradata oracle/database:19.3.0-ee
```

---
### 출처: https://bundw.tistory.com/56
