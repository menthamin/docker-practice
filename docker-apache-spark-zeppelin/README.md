- Based on the [Docker Spark](https://github.com/big-data-europe/docker-spark)
- Zepplin on http://localhost:8888
- 'spark-submit' samples
    ```bash
    docker-compose up -d --build

    docker exec -it spark-zeppelin bash
    
    cd /workspace/pyspark-samples
    $SPARK_HOME/bin/spark-submit --master spark://spark-master:7077 --executor-memory 4G --num-executors 2 ./pyspark-collect.py
    ```
    
- 출처: https://github.com/kadensungbincho/de-hands-on/tree/main/docker-apache-spark-zeppelin
- 참고자료 1: https://kadensungbincho.tistory.com/91
- 참고자료 2: https://github.com/big-data-europe/docker-spark
- 참고자료 3: https://github.com/spark-examples/pyspark-examples

- 의견: 아직 Spark에 대해 명확히 이해하지 못한 것 같다.
- Spark: 데이터 처리 역할, 분산 처리로 빠르게 데이터를 처리함