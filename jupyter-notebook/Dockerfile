# Pytohn 3.8 이미지 사용
FROM python:3.8

# 패키지 설치
RUN pip install jupyter pandas

# 스크립트 실행 경로 
WORKDIR /app  
ADD start.sh /app/
CMD ["bash", "/app/start.sh"]
