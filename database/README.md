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
-p 1521:1521 -p 5500:5500 \
-v /opt/oradata:/opt/oracle/oradata \
store/oracle/database-enterprise:12.2.0.1

# -e ORACLE_SID=oracle2 \
# -e ORACLE_PDB=oracledb1 \
# -e ORACLE_PWD=oracle \
```

## docker root 패스워드로 접근하기
```
docker exec -it --user root oracle-12c /bin/bash
chown oracle -R /opt/oracle
```

## 접속테스트
- 접속관련 참고자료
- service_names에 별칭을 줄수 있음
```
sqlplus sys/Oradoc_db1@//localhost:1614/ORCLCDB as sysdba
sqlplus system/Oradoc_db1@//localhost:1614/ORCLCDB.localdomain
sqlplus pdbadmin/Oradoc_db1@//localhost:1614/ORCLPDB1

sqlplus sys/Oradoc_db1@//localhost:1614/ORCLCDB.localdomain as sysdba
sqlplus system/Oradoc_db1@localhost:1614/ORCLCDB.localdomain
sqlplus pdbadmin/Oradoc_db1@//localhost:1614/ORCLPDB1.localdomain

sqlplus system/Oradoc_db1@localhost:1614/ORCLCDB.localdomain

show parameter db_name
show parameter service
alter system set service_names="ORCLCDB.localdomain",ORCLCDB,AAA;

sqlplus system/Oradoc_db1@localhost:1614/AAA
```

## 한글적용 참고자료
- http://1004lucifer.blogspot.com/2019/11/docker-oracle-12c-oracle.html
```
Connected to:
Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production

SQL>
SQL> update sys.props$ set value$='KOREAN_KOREA.UTF8' where name='NLS_LANGUAGE';

1 row updated.

SQL> update sys.props$ set value$='UTF8' where name='NLS_CHARACTERSET';

1 row updated.

SQL> update sys.props$ set value$='UTF8' where name='NLS_NCHAR_CHARACTERSET';

1 row updated.

# 위의 UTF-8을 사용시 한글 1글자에 3byte가 사용되며 2byte사용을 원하는경우 아래의 쿼리로 업데이트를 해줘야 한다.
update sys.props$ set value$='KO16MSWIN949' where name='NLS_CHARACTERSET';
update sys.props$ set value$='KO16MSWIN949' where name='NLS_NCHAR_CHARACTERSET';
update sys.props$ set value$='AMERICAN_AMERICA.KO16MSWIN949' where name='NLS_LANGUAGE';
# 참고: https://blog.naver.com/ssarmang/20209683055




SQL> commit;

Commit complete.

SQL> shutdown; (shutdown immediate; 명령어 권장)
Database closed.
Database dismounted.
ORACLE instance shut down.
ERROR:
ORA-12514: TNS:listener does not currently know of service requested in connect
descriptor


Warning: You are no longer connected to ORACLE.
SQL>
SQL> startup;
SP2-0640: Not connected
SQL>
SQL> conn / as sysdba
Connected to an idle instance.
SQL>
SQL> startup;
ORACLE instance started.
```

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

## sqlplus Insert 시 한글깨짐 해결
```
export NLS_LANG=KOREAN_KOREA.AL32UTF8

 

쉘의 시작설정에 위의 값을 넣어준다.

 

시작설정??

/etc/profile
나
/home/(user_id)/.bash_profile


출처: https://taisou.tistory.com/622 [Release Center]
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

타임존 변경
```
As of Docker 17.06-ce, Docker does not yet provide a way to pass down the TZ Unix environment variable from the host to the container. Because of that all containers run in the UTC timezone. If you would like to have your database run in a different timezone you can pass on the TZ environment variable within the docker run command via the -e option. An example would be: docker run ... -e TZ="Europe/Vienna" oracle/database:12.2.0.1-ee. Another option would be to specify two read-only volume mounts: docker run ... -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro oracle/database:12.2.0.1-ee. This will synchronize the timezone of the the container with that of the Docker host.
```