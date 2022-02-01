FROM python:3.8  # Pytohn 3.8 이미지 사용

RUN pip install jupyter pandas  # 패키지 설치
 
WORKDIR /app  # 스크립트 실행 경로
ADD start.sh /app/
CMD ["bash", "/app/start.sh"]
