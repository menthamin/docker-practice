# docker-practice
Docker practice
+ 파일 실행 예시
```bash
# docker-compose -f <파일명> up -d
# 옵션 설명: docker-compose -f          ← -f --file stringArray     Compose configuration files
# 옵션 설명: docker-compose up -d       ← -d --detach               Detached mode: Run containers in the background
docker-compose -f oracle-docker-compose.yml up -d
```
