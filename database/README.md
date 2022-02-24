# Oracle 12 enterprise 설치
- 참고자료: https://gomguk.tistory.com/69
- 오라클 공식이미지 링크: https://hub.docker.com/_/oracle-database-enterprise-edition?tab=resources

## 도커이미지 pull 및 확인 
```bash
docker pull store/oracle/database-enterprise:12.2.0.1
docker images | grep oracle
```

## docker run
- docker run 참고자료: https://github.com/oracle/docker-images/tree/main/OracleDatabase/SingleInstance
```bash
docker run -d --name oracle-12c \
-p 1614:1521 -p 5500:5500 \
-v /opt/oradata:/opt/oracle/oradata \
store/oracle/database-enterprise:12.2.0.1

# -e ORACLE_SID=oracle2 \
# -e ORACLE_PDB=oracledb1 \
# -e ORACLE_PWD=oracle \
```

## 접속테스트
- 접속관련 참고자료
- service_names에 별칭을 줄수 있음
```
sqlplus sys/Oradoc_db1@//localhost:1614/ORCLCDB as sysdba
sqlplus system/Oradoc_db1@//localhost:1614/ORCLCDB
sqlplus pdbadmin/Oradoc_db1@//localhost:1614/ORCLPDB1

sqlplus sys/Oradoc_db1@//localhost:1614/ORCLCDB.localdomain as sysdba
sqlplus system/Oradoc_db1@localhost:1614/ORCLCDB.localdomain
sqlplus pdbadmin/Oradoc_db1@//localhost:1614/ORCLPDB1.localdomain
```

## 한글적용 참고자료
- http://1004lucifer.blogspot.com/2019/11/docker-oracle-12c-oracle.html

## 옵션이 안먹는거 같다.
- 아래는 기본정보
- 출처: https://hub.docker.com/_/oracle-database-enterprise-edition?tab=reviews
```
Connection string to connect to docker container.
jdbc:oracle:thin:@localhost:1521:ORCLCDB
The super user name and password.
User Name : sys
Password  : Oradoc_db1
Login into the database with the administrator account.


ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- Create New Table Space
CREATE TABLESPACE new_user_tablespace
   DATAFILE 'new_user_tablespace.dbf'
   SIZE 1m;

-- Create New User
CREATE USER new_user IDENTIFIED BY "YourPassword123";

-- Grant Permissions
grant create session to new_user;
grant create table to new_user;
grant create session to new_user;
grant create table to new_user;
alter user new_user quota unlimited on users;
grant create view, create procedure, create sequence to new_user;

-- Grant Permissions to Table Space
alter user new_user quota unlimited on new_user_tablespace;
grant UNLIMITED TABLESPACE TO new_user;
```



## Docker run 옵션 참고자료
```bash
docker run --name <container name> \
-p <host port>:1521 -p <host port>:5500 \
-e ORACLE_SID=<your SID> \
-e ORACLE_PDB=<your PDB name> \
-e ORACLE_PWD=<your database passwords> \
-e INIT_SGA_SIZE=<your database SGA memory in MB> \
-e INIT_PGA_SIZE=<your database PGA memory in MB> \
-e ORACLE_EDITION=<your database edition> \
-e ORACLE_CHARACTERSET=<your character set> \
-e ENABLE_ARCHIVELOG=true \
-v [<host mount point>:]/opt/oracle/oradata \
oracle/database:21.3.0-ee

Parameters:
   --name:        The name of the container (default: auto generated).
   -p:            The port mapping of the host port to the container port.
                  Two ports are exposed: 1521 (Oracle Listener), 5500 (OEM Express).
   -e ORACLE_SID: The Oracle Database SID that should be used (default: ORCLCDB).
   -e ORACLE_PDB: The Oracle Database PDB name that should be used (default: ORCLPDB1).
   -e ORACLE_PWD: The Oracle Database SYS, SYSTEM and PDB_ADMIN password (default: auto generated).
   -e INIT_SGA_SIZE:
                  The total memory in MB that should be used for all SGA components (optional).
                  Supported 19.3 onwards.
   -e INIT_PGA_SIZE:
                  The target aggregate PGA memory in MB that should be used for all server processes attached to the instance (optional).
                  Supported 19.3 onwards.
   -e ORACLE_EDITION:
                  The Oracle Database Edition (enterprise/standard).
                  Supported 19.3 onwards.
   -e ORACLE_CHARACTERSET:
                  The character set to use when creating the database (default: AL32UTF8).
   -e ENABLE_ARCHIVELOG:
                  To enable archive log mode when creating the database (default: false).
                  Supported 19.3 onwards.
   -v /opt/oracle/oradata
                  The data volume to use for the database.
                  Has to be writable by the Unix "oracle" (uid: 54321) user inside the container!
                  If omitted the database will not be persisted over container recreation.
   -v /opt/oracle/scripts/startup | /docker-entrypoint-initdb.d/startup
                  Optional: A volume with custom scripts to be run after database startup.
                  For further details see the "Running scripts after setup and on startup" section below.
   -v /opt/oracle/scripts/setup | /docker-entrypoint-initdb.d/setup
                  Optional: A volume with custom scripts to be run after database setup.
                  For further details see the "Running scripts after setup and on startup" section below.
```

